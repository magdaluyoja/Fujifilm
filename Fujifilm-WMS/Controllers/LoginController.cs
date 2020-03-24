using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;
using Fujifilm_WMS.Models;

namespace Fujifilm_WMSSystem.Controllers
{
    [AllowAnonymous]
    public class LoginController : Controller
    {
        List<string> modelErrors = new List<string>();
        string errmsg;

        // GET: Login
        public ActionResult Index()
        {
            if (Session["ID"] != null)
            {
                return RedirectToAction("Index", "Home", new { area = "" });
            }
            else
            {
                return View("Login");
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LoginEntry(Login data)
        {
            try
            {
                Security ph = new Security();
                int ID = 0;
                string Username = "";
                string FirstName = "";
                string Email = "";
                string Department = "";
                string DepartmentName = "";
                string username = data.Username;
                string password = ph.base64Encode(data.Password.ToString());

                DataHelper dataHelper = new DataHelper();

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "User_Login";

                        cmdSql.Parameters.Clear();
                        cmdSql.Parameters.AddWithValue("@Username", username);
                        cmdSql.Parameters.AddWithValue("@Password", password);

                        using (SqlDataReader rdSql = cmdSql.ExecuteReader())
                        {
                            if (rdSql.Read())
                            {
                                ID = Convert.ToInt32(rdSql["ID"]);
                                Username = rdSql["Username"].ToString();
                                Email = rdSql["Email"].ToString();
                                Department = rdSql["Department"].ToString();
                                DepartmentName = rdSql["DepartmentName"].ToString();
                                FirstName = rdSql["FirstName"].ToString();

                                Session["ID"] = ID;
                                Session["Username"] = Username;
                                Session["Email"] = Email;
                                Session["Department"] = Department;
                                Session["DepartmentName"] = DepartmentName;
                                Session["FirstName"] = FirstName;
                            }
                            else
                            {
                                errmsg = "Invalid Username or Password. Please try again.";
                            }
                        }
                    }
                }
            }
            catch (Exception err)
            {
                if (err.InnerException != null)
                    errmsg = "Error: " + err.InnerException.ToString();
                else
                    errmsg = "Error: " + err.Message.ToString();
            }
            if (errmsg != null)
                return Json(new { success = true, data = new { error = true, errmsg = errmsg } });
            else
            {
                return Json(new { success = true, data = new { error = false } });
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout(int ID)
        {
            Session.Abandon();
            return RedirectToAction("Index", "Login", new { area = "" });
        }
        public ActionResult SessionError()
        {
            return Json(new { success = false, type = "Login", errors = "Session has expired. Please login again. Thank you." }, JsonRequestBehavior.AllowGet);
        }
    }
}
