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
    public class LocationMasterController : Controller
    {
        Security ph = new Security();
        DataHelper dataHelper = new DataHelper();
        List<string> modelErrors = new List<string>();
        bool error = false;
        string errmsg = "";
        // GET: MasterMaintenance/LocationMaster
        public ActionResult Index()
        {
            return View("LocationMaster");
        }

        public ActionResult GetLocationList()
        {
            List<LocationMaster> data = new List<LocationMaster>();
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
                        cmdSql.CommandText = "select a.* from [Fujifilm_WMS].[dbo].[mLocation] a where a.IsDeleted=0";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new LocationMaster
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    Area = sdr["Area"].ToString(),
                                    Position = sdr["Position"].ToString(),
                                    X = Convert.ToInt32(sdr["X"].ToString()),
                                    Y = Convert.ToInt32(sdr["Y"].ToString()),
                                    Z = Convert.ToInt32(sdr["Z"].ToString()),
                                    PalletCapacity = Convert.ToDecimal(sdr["PalletCapacity"].ToString()),
                                    BoxCapacity = Convert.ToDecimal(sdr["BoxCapacity"].ToString()),
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
                                    x.Area.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Position.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Status.ToString().Contains(searchValue.ToLower())
                                 ).ToList<LocationMaster>();

            int totalrowsafterfiltering = data.Count;
            if (sortDirection == "asc")
                data = data.OrderBy(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            if (sortDirection == "desc")
                data = data.OrderByDescending(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            data = data.Skip(start).Take(length).ToList<LocationMaster>();


            return Json(new { data = data, draw = Request["draw"], recordsTotal = totalrows, recordsFiltered = totalrowsafterfiltering }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveLocation(LocationMaster locationMaster)
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
                            cmdSql.CommandText = "LocationMaster_InsertUpdate";
                            cmdSql.Parameters.Clear();
                            cmdSql.Parameters.AddWithValue("@ID", locationMaster.ID);
                            cmdSql.Parameters.AddWithValue("@Area", locationMaster.Area);
                            cmdSql.Parameters.AddWithValue("@Position", locationMaster.Position);
                            cmdSql.Parameters.AddWithValue("@X", locationMaster.X);
                            cmdSql.Parameters.AddWithValue("@Y", locationMaster.Y);
                            cmdSql.Parameters.AddWithValue("@Z", locationMaster.Z);
                            cmdSql.Parameters.AddWithValue("@PalletCapacity", locationMaster.PalletCapacity);
                            cmdSql.Parameters.AddWithValue("@BoxCapacity", locationMaster.BoxCapacity);
                            cmdSql.Parameters.AddWithValue("@Status", locationMaster.Status);
                            cmdSql.Parameters.AddWithValue("@IsDeleted", 0);
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
                return Json(new { success = true, msg = "Location was successfully " + endMsg });
            }
        }

        public ActionResult GetLocationDetails(string ID)
        {
            LocationMaster locationDetails = new LocationMaster();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    string getLocationSql = "select a.* from [Fujifilm_WMS].[dbo].[mLocation] a where a.IsDeleted=0 AND a.ID='" + ID + "'";
                    using (SqlCommand comm = new SqlCommand(getLocationSql, conn))
                    {
                        SqlDataReader reader = comm.ExecuteReader();
                        if (!reader.Read())
                            throw new InvalidOperationException("No records found.");

                        locationDetails.ID = Convert.ToInt32(reader["ID"]);
                        locationDetails.Area = reader["Area"].ToString();
                        locationDetails.Position = reader["Position"].ToString();
                        locationDetails.X = Convert.ToInt32(reader["X"].ToString());
                        locationDetails.Y = Convert.ToInt32(reader["Y"].ToString());
                        locationDetails.Z = Convert.ToInt32(reader["Z"].ToString());
                        locationDetails.PalletCapacity = Convert.ToDecimal(reader["PalletCapacity"].ToString());
                        locationDetails.BoxCapacity = Convert.ToDecimal(reader["BoxCapacity"].ToString());
                        locationDetails.Status = Convert.ToInt32(reader["Status"].ToString());
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
            return Json(new { success = true, data = new { locationData = locationDetails } }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteLocation(string ID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "LocationMaster_Delete";

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
            return Json(new { success = true, msg = "Location was successfully deleted." });

        }
    }
}