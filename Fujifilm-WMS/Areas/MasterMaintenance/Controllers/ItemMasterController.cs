using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using Fujifilm_WMS.Areas.MasterMaintenance.Models;
using Fujifilm_WMS.Models;

namespace Fujifilm_WMS.Areas.MasterMaintenance.Controllers
{
    public class ItemMasterController : Controller
    {
        Security ph = new Security();
        DataHelper dataHelper = new DataHelper();
        List<string> modelErrors = new List<string>();
        bool error = false;
        string errmsg = "";
        // GET: MasterMaintenance/ItemMaster
        public ActionResult Index()
        {
            return View("ItemMaster");
        }

        public ActionResult GetItemList()
        {
            List<mItemMaster> data = new List<mItemMaster>();
            DataTableHelper TypeHelper = new DataTableHelper();

            int start = Convert.ToInt32(Request["start"]);
            int length = Convert.ToInt32(Request["length"]);
            string searchValue = Request["search[value]"];
            string sortColumnName = Request["columns[" + Request["order[0][column]"] + "][data]"];
            string sortDirection = Request["order[0][dir]"];

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "select a.*, b.Value as ModelValue, c.Value as CategoryValue, d.Value as UOMValue from [Fujifilm_WMS].[dbo].[mItemMaster] a left join mGeneral b on a.Model=b.ID left join mGeneral c on a.Category=c.ID left join mGeneral d on a.UOM=d.ID where a.IsDeleted=0";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new mItemMaster
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    PartNumber = sdr["PartNumber"].ToString(),
                                    PartName = sdr["PartName"].ToString(),
                                    Model = sdr["ModelValue"].ToString(),
                                    Category = sdr["CategoryValue"].ToString(),
                                    Status = Convert.ToInt32(sdr["Status"]),
                                    UOM = sdr["UOMValue"].ToString(),
                                });
                            }

                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception err)
            {
                string errmsg;
                if (err.InnerException != null)
                    errmsg = "An error occured: " + err.InnerException.ToString();
                else
                    errmsg = "An error occured: " + err.Message.ToString();

                return Json(new { success = false, msg = errmsg }, JsonRequestBehavior.AllowGet);
            }
            int totalrows = data.Count;
            if (!string.IsNullOrEmpty(searchValue))//filter
                data = data.Where(x =>
                                    x.PartNumber.ToLower().Contains(searchValue.ToLower()) ||
                                    x.PartName.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Model.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Category.ToLower().Contains(searchValue.ToLower()) ||
                                    x.UOM.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Status.ToString().Contains(searchValue.ToLower())
                                 ).ToList<mItemMaster>();

            int totalrowsafterfiltering = data.Count;
            if (sortDirection == "asc")
                data = data.OrderBy(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            if (sortDirection == "desc")
                data = data.OrderByDescending(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            data = data.Skip(start).Take(length).ToList<mItemMaster>();


            return Json(new { data = data, draw = Request["draw"], recordsTotal = totalrows, recordsFiltered = totalrowsafterfiltering }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveItem(mItemMaster Item)
        {
            string endMsg = "";
            ModelState.Remove("ID");
            if (ModelState.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ToString()))
                    {
                        conn.Open();
                        using (SqlCommand cmdSql = conn.CreateCommand())
                        {

                            cmdSql.CommandType = CommandType.StoredProcedure;
                            cmdSql.CommandText = "ItemMaster_InsertUpdate";
                            cmdSql.Parameters.Clear();
                            cmdSql.Parameters.AddWithValue("@ID", Item.ID);
                            cmdSql.Parameters.AddWithValue("@PartNumber", Item.PartNumber);
                            cmdSql.Parameters.AddWithValue("@PartName", Item.PartName);
                            cmdSql.Parameters.AddWithValue("@Model", Item.Model);
                            cmdSql.Parameters.AddWithValue("@Category", Item.Category);
                            cmdSql.Parameters.AddWithValue("@UOM", Item.UOM);
                            cmdSql.Parameters.AddWithValue("@Status", Item.Status);
                            cmdSql.Parameters.AddWithValue("@IsDeleted", Item.IsDeleted);
                            cmdSql.Parameters.AddWithValue("@CreateID", Session["Username"]);
                            SqlParameter EndMsg = cmdSql.Parameters.Add("@EndMsg", SqlDbType.VarChar, 200);
                            SqlParameter ErrorMessage = cmdSql.Parameters.Add("@ErrorMessage", SqlDbType.VarChar, 200);
                            SqlParameter Error = cmdSql.Parameters.Add("@Error", SqlDbType.Bit);

                            EndMsg.Direction = ParameterDirection.Output;
                            Error.Direction = ParameterDirection.Output;
                            ErrorMessage.Direction = ParameterDirection.Output;

                            cmdSql.ExecuteNonQuery();

                            error = Convert.ToBoolean(Error.Value);
                            if (error)
                                modelErrors.Add(ErrorMessage.Value.ToString());

                            endMsg = EndMsg.Value.ToString();
                        }
                        conn.Close();
                    }
                }
                catch (Exception err)
                {
                    string errmsg;
                    if (err.InnerException != null)
                        errmsg = "Error: " + err.InnerException.ToString();
                    else
                        errmsg = "Error: " + err.Message.ToString();

                    return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {
                foreach (var modelStateKey in ViewData.ModelState.Keys)
                {
                    var modelStateVal = ViewData.ModelState[modelStateKey];
                    foreach (var error in modelStateVal.Errors)
                    {
                        var key = modelStateKey;
                        var errMessage = error.ErrorMessage;
                        var exception = error.Exception;
                        modelErrors.Add(errMessage);
                    }
                }
            }
            if (modelErrors.Count != 0 || error)
                return Json(new { success = false, errors = modelErrors });
            else
            {
                return Json(new { success = true, msg = "Item was successfully " + endMsg });
            }
        }

        public ActionResult GetItemDetails(string ID)
        {
            mItemDetails itemDetails = new mItemDetails();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    string getItemSql = "SELECT a.* , (select [Value] from mGeneral where ID=a.Model) as ModelValue, (select [Value] from mGeneral where ID=a.Category) as CategoryValue, (select [Value] from mGeneral where ID=a.UOM) as UOMValue FROM [Fujifilm_WMS].[dbo].[mItemMaster] a WHERE a.IsDeleted = '0' AND a.ID='" + ID + "'";
                    using (SqlCommand comm = new SqlCommand(getItemSql, conn))
                    {
                        SqlDataReader reader = comm.ExecuteReader();
                        if (!reader.Read())
                            throw new InvalidOperationException("No records found.");

                        itemDetails.ID = Convert.ToInt32(reader["ID"]);
                        itemDetails.PartNumber = reader["PartNumber"].ToString();
                        itemDetails.PartName = reader["PartName"].ToString();
                        itemDetails.Model = reader["Model"].ToString();
                        itemDetails.ModelValue = reader["ModelValue"].ToString();
                        itemDetails.Category = reader["Category"].ToString();
                        itemDetails.CategoryValue = reader["CategoryValue"].ToString();
                        itemDetails.UOM = reader["UOM"].ToString();
                        itemDetails.UOMValue = reader["UOMValue"].ToString();
                        itemDetails.Status = Convert.ToInt32(reader["Status"].ToString());
                    }
                    conn.Close();
                }
            }
            catch (Exception err)
            {
                string errmsg;
                if (err.InnerException != null)
                    errmsg = "Error: " + err.InnerException.ToString();
                else
                    errmsg = "Error: " + err.Message.ToString();

                return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = true, data = new { itemData = itemDetails } }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteItem(string ID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "ItemMaster_Delete";

                        cmdSql.Parameters.Clear();
                        cmdSql.Parameters.AddWithValue("@ID", ID);
                        cmdSql.Parameters.AddWithValue("@UpdateID", Session["Username"]);

                        SqlParameter Error = cmdSql.Parameters.Add("@Error", SqlDbType.Bit);
                        SqlParameter ErrorMessage = cmdSql.Parameters.Add("@ErrorMessage", SqlDbType.NVarChar, 50);

                        Error.Direction = ParameterDirection.Output;
                        ErrorMessage.Direction = ParameterDirection.Output;

                        cmdSql.ExecuteNonQuery();

                        error = Convert.ToBoolean(Error.Value);
                        if (error)
                            modelErrors.Add(ErrorMessage.Value.ToString());
                    }
                    conn.Close();
                }
            }
            catch (Exception err)
            {
                string errmsg;
                if (err.InnerException != null)
                    errmsg = "Error: " + err.InnerException.ToString();
                else
                    errmsg = "Error: " + err.Message.ToString();

                return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = true, msg = "Item was successfully deleted." });

        }

    }
}