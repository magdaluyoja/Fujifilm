using Fujifilm_WMS.Areas.MasterMaintenance.Models;
using Fujifilm_WMS.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;

namespace Fujifilm_WMS.Areas.MasterMaintenance.Controllers
{
    public class CostCenterController : Controller
    {
        Security ph = new Security();
        DataHelper dataHelper = new DataHelper();
        List<string> modelErrors = new List<string>();
        bool error = false;
        string errmsg = "";
        // GET: MasterMaintenance/CostCenter
        public ActionResult Index()
        {
            return View("CostCenter");
        }

        public ActionResult GetCostCenterList()
        {
            List<mCostCenterMaster> data = new List<mCostCenterMaster>();
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
                        cmdSql.CommandText = "select a.*, (select Value from mGeneral where ID=a.DepartmentID) as DepartmentName from [Fujifilm_WMS].[dbo].[mCostCenter] a where a.IsDeleted=0";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new mCostCenterMaster
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    DepartmentID = Convert.ToInt32(sdr["DepartmentID"].ToString()),
                                    DepartmentName = sdr["DepartmentName"].ToString(),
                                    CostCenterCode = sdr["CostCenterCode"].ToString(),
                                    CostCenterName = sdr["CostCenterName"].ToString(),
                                    Status = Convert.ToInt32(sdr["Status"]),
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
                                    x.DepartmentName.ToLower().Contains(searchValue.ToLower()) ||
                                    x.CostCenterCode.ToLower().Contains(searchValue.ToLower()) ||
                                    x.CostCenterName.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Status.ToString().Contains(searchValue.ToLower())
                                 ).ToList<mCostCenterMaster>();

            int totalrowsafterfiltering = data.Count;
            if (sortDirection == "asc")
                data = data.OrderBy(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            if (sortDirection == "desc")
                data = data.OrderByDescending(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            data = data.Skip(start).Take(length).ToList<mCostCenterMaster>();


            return Json(new { data = data, draw = Request["draw"], recordsTotal = totalrows, recordsFiltered = totalrowsafterfiltering }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveCostCenter(mCostCenterMaster CostCenter)
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
                            cmdSql.CommandText = "CostCenterMaster_InsertUpdate";
                            cmdSql.Parameters.Clear();
                            cmdSql.Parameters.AddWithValue("@ID", CostCenter.ID);
                            cmdSql.Parameters.AddWithValue("@DepartmentID", CostCenter.DepartmentID);
                            cmdSql.Parameters.AddWithValue("@CostCenterCode", CostCenter.CostCenterCode);
                            cmdSql.Parameters.AddWithValue("@CostCenterName", CostCenter.CostCenterName);
                            cmdSql.Parameters.AddWithValue("@Status", CostCenter.Status);
                            cmdSql.Parameters.AddWithValue("@IsDeleted", CostCenter.IsDeleted);
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
                return Json(new { success = true, msg = "Cost Center was successfully " + endMsg });
            }
        }

        public ActionResult GetCostCenterDetails(string ID)
        {
            mCostCenterMaster costCenterDetails = new mCostCenterMaster();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    string getItemSql = "select a.*, (select Value from mGeneral where ID=a.DepartmentID) as DepartmentName from [Fujifilm_WMS].[dbo].[mCostCenter] a where a.IsDeleted=0 AND a.ID='" + ID + "'";
                    using (SqlCommand comm = new SqlCommand(getItemSql, conn))
                    {
                        SqlDataReader reader = comm.ExecuteReader();
                        if (!reader.Read())
                            throw new InvalidOperationException("No records found.");

                        costCenterDetails.ID = Convert.ToInt32(reader["ID"]);
                        costCenterDetails.DepartmentID = Convert.ToInt32(reader["DepartmentID"].ToString());
                        costCenterDetails.DepartmentName = reader["DepartmentName"].ToString();
                        costCenterDetails.CostCenterCode = reader["CostCenterCode"].ToString();
                        costCenterDetails.CostCenterName = reader["CostCenterName"].ToString();
                        costCenterDetails.Status = Convert.ToInt32(reader["Status"].ToString());
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
            return Json(new { success = true, data = new { costCenterData = costCenterDetails } }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteCostCenter(string ID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "CostCenterMaster_Delete";

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
            return Json(new { success = true, msg = "Cost Center was successfully deleted." });

        }
    }
}
