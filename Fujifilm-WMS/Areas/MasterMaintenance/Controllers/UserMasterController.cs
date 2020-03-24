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
    public class UserMasterController : Controller
    {
        Security ph = new Security();
        DataHelper dataHelper = new DataHelper();
        List<string> modelErrors = new List<string>();
        bool error = false;
        string errmsg = "";

        public ActionResult Index()
        {
            return View("UserMaster");
        }
        public ActionResult GetUserList()
        {
            List<mUser> data = new List<mUser>();
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
                        cmdSql.CommandText = "select a.*, b.Value as DepartmentName from mUsers a left join mGeneral b on a.Department=b.ID where a.IsDeleted=0";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new mUser
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    Username = sdr["Username"].ToString(),
                                    Email = sdr["Email"].ToString(),
                                    FirstName = sdr["FirstName"].ToString(),
                                    LastName = sdr["LastName"].ToString(),
                                    Department = sdr["DepartmentName"].ToString(),
                                    PostFunction_Approver = Convert.ToInt32(sdr["PostFunction_Approver"]),
                                    Role = sdr["Role"].ToString(),
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
                                    x.Username.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Email.ToLower().Contains(searchValue.ToLower()) ||
                                    x.FirstName.ToLower().Contains(searchValue.ToLower()) ||
                                    x.LastName.ToLower().Contains(searchValue.ToLower()) ||
                                    x.Department.ToLower().Contains(searchValue.ToLower()) ||
                                    x.PostFunction_Approver.ToString().Contains(searchValue.ToLower()) ||
                                    x.Role.ToLower().Contains(searchValue.ToLower())
                                 ).ToList<mUser>();

            int totalrowsafterfiltering = data.Count;
            if (sortDirection == "asc")
                data = data.OrderBy(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            if (sortDirection == "desc")
                data = data.OrderByDescending(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            data = data.Skip(start).Take(length).ToList<mUser>();


            return Json(new { data = data, draw = Request["draw"], recordsTotal = totalrows, recordsFiltered = totalrowsafterfiltering }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ValidateUsername(string Username)
        {
            bool isValid = true;
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "SELECT Username FROM mUsers WHERE IsDeleted=0 AND Username='" + Username + "'";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            if (sdr.HasRows)
                                isValid = false;
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception err)
            {
                if (err.InnerException != null)
                    errmsg = "An error occured: " + err.InnerException.ToString();
                else
                    errmsg = "An error occured: " + err.Message.ToString(); ;
                error = true;
            }
            if (error)
                return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
            else
            {
                return Json(new { success = true, data = new { isValid = isValid } });
            }
        }
        public ActionResult ValidateEmail(string Email)
        {
            bool isValid = true;
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "SELECT Email FROM mUsers WHERE IsDeleted=0 AND Email='" + Email + "'";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            if (sdr.HasRows)
                                isValid = false;
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception err)
            {
                if (err.InnerException != null)
                    errmsg = "An error occured: " + err.InnerException.ToString();
                else
                    errmsg = "An error occured: " + err.Message.ToString(); ;
                error = true;
            }
            if (error)
                return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
            else
            {
                return Json(new { success = true, data = new { isValid = isValid } });
            }
        }
        public ActionResult SaveUser(mUser User)
        {
            string endMsg = "";
            ModelState.Remove("ID");
            if (ModelState.IsValid)
            {
                try
                {
                    int ReadAndWrite = 0;
                    int CanDelete = 0;
                    if (User.Role == "Administrator")
                    {
                        ReadAndWrite = 1;
                        CanDelete = 1;
                    }
                    if (User.Role == "Encoder")
                    {
                        ReadAndWrite = 1;
                        CanDelete = 0;
                    }
                    if (User.Role == "Viewer")
                    {
                        ReadAndWrite = 0;
                        CanDelete = 0;
                    }

                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ToString()))
                    {
                        conn.Open();
                        using (SqlCommand cmdSql = conn.CreateCommand())
                        {
                            User.Password = ph.base64Encode(User.Password).ToString();

                            cmdSql.CommandType = CommandType.StoredProcedure;
                            cmdSql.CommandText = "User_InsertUpdate";
                            cmdSql.Parameters.Clear();
                            cmdSql.Parameters.AddWithValue("@ID", User.ID);
                            cmdSql.Parameters.AddWithValue("@Username", User.Username);
                            cmdSql.Parameters.AddWithValue("@Password", User.Password);
                            cmdSql.Parameters.AddWithValue("@Email", User.Email);
                            cmdSql.Parameters.AddWithValue("@FirstName", User.FirstName);
                            cmdSql.Parameters.AddWithValue("@LastName", User.LastName);
                            cmdSql.Parameters.AddWithValue("@Department", User.Department);
                            cmdSql.Parameters.AddWithValue("@PostFunction_Approver", User.PostFunction_Approver);
                            cmdSql.Parameters.AddWithValue("@Role", User.Role);
                            cmdSql.Parameters.AddWithValue("@ReadAndWrite", ReadAndWrite);
                            cmdSql.Parameters.AddWithValue("@CanDelete", CanDelete);
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
                return Json(new { success = true, msg = "User was successfully " + endMsg });
            }
        }
        public ActionResult GetUserDetails(string Username)
        {
            mUser userDetails = new mUser();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    string getUserSql = "SELECT u.*, (SELECT value FROM[mGeneral] where ID = u.Department) as DepartmentDesc FROM mUsers as u WHERE u.IsDeleted = '0' AND Username='" + Username + "'";
                    using (SqlCommand comm = new SqlCommand(getUserSql, conn))
                    {
                        SqlDataReader reader = comm.ExecuteReader();
                        if (!reader.Read())
                            throw new InvalidOperationException("No records found.");

                        userDetails.ID = Convert.ToInt32(reader["ID"]);
                        userDetails.Username = reader["Username"].ToString();
                        userDetails.Password = ph.base64Decode(reader["Password"].ToString());
                        userDetails.Email = reader["Email"].ToString();
                        userDetails.FirstName = reader["FirstName"].ToString();
                        userDetails.LastName = reader["LastName"].ToString();
                        userDetails.Department = reader["Department"].ToString();
                        userDetails.DepartmentDesc = reader["DepartmentDesc"].ToString();
                        userDetails.PostFunction_Approver = Convert.ToInt32(reader["PostFunction_Approver"]);
                        userDetails.Role = reader["Role"].ToString();
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
            return Json(new { success = true, data = new { userData = userDetails } }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteUser(string Username)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "User_Delete";

                        cmdSql.Parameters.Clear();
                        cmdSql.Parameters.AddWithValue("@Username", Username);
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
            return Json(new { success = true, msg = "User was successfully deleted." });

        }
        public ActionResult GetUserAccess(int ID)
        {

            ArrayList userMenuList = new ArrayList();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "UserPageAccess_GetAccessList";
                        cmdSql.Parameters.Clear();
                        cmdSql.Parameters.AddWithValue("@ID", ID);
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                //var userid = Session["UserID"].ToString();
                                userMenuList.Add(new
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    GroupLabel = sdr["GroupLabel"].ToString(),
                                    PageName = sdr["PageName"].ToString(),
                                    PageLabel = sdr["PageLabel"].ToString(),
                                    URL = sdr["URL"].ToString(),
                                    HasSub = Convert.ToInt32(sdr["HasSub"]),
                                    ParentMenu = sdr["ParentMenu"].ToString(),
                                    ParentOrder = Convert.ToInt32(sdr["ParentOrder"]),
                                    Order = Convert.ToInt32(sdr["Order"]),
                                    Icon = sdr["Icon"].ToString(),
                                    Status = sdr["Status"].ToString() == "" ? 0 : Convert.ToInt32(sdr["Status"]),
                                    ReadAndWrite = sdr["ReadAndWrite"].ToString() == "" ? 0 : Convert.ToInt32(sdr["ReadAndWrite"]),
                                    Delete = sdr["Delete"].ToString() == "" ? 0 : Convert.ToInt32(sdr["Delete"])
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

                return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = true, data = userMenuList }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveUserAccess(List<mUserPageAccess> userAccessList)
        {
            string endMsg = " saved.";
            ModelState.Remove("ID");
            if (ModelState.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ToString()))
                    {
                        conn.Open();
                        SqlTransaction transaction;
                        transaction = conn.BeginTransaction();
                        try
                        {
                            foreach (mUserPageAccess userAccess in userAccessList)
                            {
                                using (SqlCommand cmdSql = conn.CreateCommand())
                                {
                                    cmdSql.Connection = conn;
                                    cmdSql.Transaction = transaction;
                                    cmdSql.CommandType = CommandType.StoredProcedure;
                                    cmdSql.CommandText = "UserPageAccess_INSERT_UPDATE";

                                    cmdSql.Parameters.Clear();
                                    cmdSql.Parameters.AddWithValue("@UserID", Convert.ToInt32(userAccess.UserID));
                                    cmdSql.Parameters.AddWithValue("@PageID", userAccess.PageID);
                                    cmdSql.Parameters.AddWithValue("@Status", userAccess.Status);
                                    cmdSql.Parameters.AddWithValue("@ReadAndWrite", userAccess.ReadAndWrite);
                                    cmdSql.Parameters.AddWithValue("@Delete", userAccess.Delete);
                                    cmdSql.Parameters.AddWithValue("@CreateID", Session["ID"].ToString());
                                    SqlParameter ErrorMessage = cmdSql.Parameters.Add("@ErrorMessage", SqlDbType.VarChar, 200);
                                    SqlParameter Error = cmdSql.Parameters.Add("@Error", SqlDbType.Bit);

                                    Error.Direction = ParameterDirection.Output;
                                    ErrorMessage.Direction = ParameterDirection.Output;

                                    cmdSql.ExecuteNonQuery();

                                    error = Convert.ToBoolean(Error.Value);
                                    if (error)
                                    {
                                        modelErrors.Add(ErrorMessage.Value.ToString());
                                        //throw new System.InvalidOperationException(ErrorMessage.Value.ToString());
                                    }
                                }
                            }
                            transaction.Commit();
                        }
                        catch (Exception err)
                        {
                            if (err.InnerException != null)
                                modelErrors.Add("An error occured: " + err.InnerException.ToString());
                            else
                                modelErrors.Add("An error occured: " + err.Message.ToString());
                            error = true;
                        }

                        conn.Close();
                    }
                }
                catch (Exception err)
                {
                    if (err.InnerException != null)
                        modelErrors.Add("An error occured: " + err.InnerException.ToString());
                    else
                        modelErrors.Add("An error occured: " + err.Message.ToString());
                    error = true;
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
                return Json(new { success = true, msg = "User Page Access was successfully " + endMsg });
        }
    }
}
