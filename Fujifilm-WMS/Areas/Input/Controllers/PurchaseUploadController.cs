using Fujifilm_WMS.Areas.Input.Models;
using Fujifilm_WMS.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.Mvc;
namespace Fujifilm_WMS.Areas.Input.Controllers
{
    public class PurchaseUploadController : Controller
    {
        List<string> modelErrors = new List<string>();
        bool error = false;
        string errmsg = "";
        public ActionResult Index()
        {
            return View("PurchaseUpload");
        }
        public ActionResult UploadFile()
        {
            string filePath = string.Empty;
            List<PurchaseUpload> PurchaseUploadList = new List<PurchaseUpload>();
            if (HttpContext.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var UploadedFile = HttpContext.Request.Files["PurchaseUpload"];
                try
                {
                    string path = Server.MapPath("~/Areas/Input/Uploads/PurchaseUpload/");
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }

                    filePath = path + Path.GetFileName(UploadedFile.FileName);
                    string extension = Path.GetExtension(UploadedFile.FileName);
                    UploadedFile.SaveAs(filePath);

                    string conString = string.Empty;
                    switch (extension)
                    {
                        case ".xls": //Excel 97-03.
                            conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                            break;
                        case ".xlsx": //Excel 07 and above.
                            conString = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                            break;
                    }

                    conString = string.Format(conString, filePath);

                    using (OleDbConnection connExcel = new OleDbConnection(conString))
                    {
                        using (OleDbCommand cmdExcel = new OleDbCommand())
                        {
                            using (OleDbDataAdapter odaExcel = new OleDbDataAdapter())
                            {
                                DataTable dtPurchase = new DataTable();
                                cmdExcel.Connection = connExcel;

                                //Get the name of First Sheet.
                                connExcel.Open();
                                DataTable dtExcelSchema;
                                dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                                string sheet = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString().Replace("'", "") + "A4:AA1048576";

                                cmdExcel.CommandText = "SELECT * From [" + sheet + "]";
                                odaExcel.SelectCommand = cmdExcel;
                                odaExcel.Fill(dtPurchase);

                                int NoError = 1;
                                try
                                {
                                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ToString()))
                                    {
                                        conn.Open();
                                        SqlTransaction transaction;
                                        transaction = conn.BeginTransaction();
                                        try
                                        {

                                            int ExpenseCounter = 2;
                                            string ExpenseErrorMsg = "";
                                            bool ExpenseIsValid = true;
                                            #region

                                            foreach (DataRow row in dtPurchase.Rows)
                                            {
                                                ExpenseCounter++;
                                                if (row[0].ToString() == "xxx")
                                                    break;

                                                #region
                                                string descDt = row[3].ToString();
                                                DateTime aDate = DateTime.Parse(descDt);
                                                string PO_Issued_Date = aDate.ToString("MM/dd/yyyy");
                                                string reqDt = row[9].ToString();
                                                DateTime aReqDate = DateTime.Parse(reqDt);
                                                string Requested_Delivery_Date = aReqDate.ToString("MM/dd/yyyy");

                                                using (SqlCommand cmdSql = conn.CreateCommand())
                                                {
                                                    cmdSql.Connection = conn;
                                                    cmdSql.Transaction = transaction;
                                                    cmdSql.CommandType = CommandType.StoredProcedure;
                                                    cmdSql.CommandText = "pPurchaseOrderUpload_Insert";

                                                    cmdSql.Parameters.Clear();

                                                    cmdSql.Parameters.AddWithValue("@NoError", NoError);
                                                    cmdSql.Parameters.AddWithValue("@Department", row[0]);
                                                    cmdSql.Parameters.AddWithValue("@Vendor_Code", row[1]);
                                                    cmdSql.Parameters.AddWithValue("@Vendor_Name", row[2]);
                                                    cmdSql.Parameters.AddWithValue("@PO_Issued_Date", PO_Issued_Date);
                                                    cmdSql.Parameters.AddWithValue("@PO_No", row[4]);
                                                    cmdSql.Parameters.AddWithValue("@PO_Ln_No", row[5]);
                                                    cmdSql.Parameters.AddWithValue("@Material", row[6]);
                                                    cmdSql.Parameters.AddWithValue("@Material_Description", row[7]);
                                                    cmdSql.Parameters.AddWithValue("@Unit", row[8]);
                                                    cmdSql.Parameters.AddWithValue("@Requested_Delivery_Date", Requested_Delivery_Date);
                                                    cmdSql.Parameters.AddWithValue("@PO_Balance", row[10]);
                                                    cmdSql.Parameters.AddWithValue("@Cost_Center", row[11]);
                                                    //cmdSql.Parameters.AddWithValue("@CreateID", Session["ID"].ToString());
                                                    SqlParameter ErrorMessage = cmdSql.Parameters.Add("@ErrorMessage", SqlDbType.VarChar, 1000);
                                                    SqlParameter Error = cmdSql.Parameters.Add("@Error", SqlDbType.Bit);

                                                    Error.Direction = ParameterDirection.Output;
                                                    ErrorMessage.Direction = ParameterDirection.Output;

                                                    cmdSql.ExecuteNonQuery();
                                                    error = Convert.ToBoolean(Error.Value);
                                                    if (error)
                                                    {
                                                        //NoError = 0;
                                                        //modelErrors.Add(ErrorMessage.Value.ToString() + "| Row " + ExpenseCounter);
                                                        //ExpenseErrorMsg = ErrorMessage.Value.ToString() + "| Row " + ExpenseCounter;
                                                        //ExpenseIsValid = false;
                                                    }
                                                    else
                                                    {
                                                        ExpenseErrorMsg = "";
                                                        ExpenseIsValid = true;
                                                    }
                                                }
                                                #endregion
                                                PurchaseUploadList.Add(new PurchaseUpload
                                                {
                                                    Department = row[0].ToString(),
                                                    Vendor = row[1].ToString(),
                                                    Vendor_Name = row[2].ToString(),
                                                    PO_Issued_Date = row[3].ToString(),
                                                    PO_No = row[4].ToString(),
                                                    PO_Ln_No = row[5].ToString(),
                                                    Material = row[6].ToString(),
                                                    Material_Description = row[7].ToString(),
                                                    Unit = row[8].ToString(),
                                                    Requested_Delivery_Date = row[9].ToString(),
                                                    PO_Balance = row[10].ToString(),
                                                    Cost_Center = row[11].ToString(),
                                                    //Year = Year,
                                                    //ErrMsg = ExpenseErrorMsg,
                                                    //IsValid = ExpenseIsValid
                                                });
                                            }
                                            #endregion
                                            if (NoError == 1)
                                                transaction.Commit();
                                            else
                                                transaction.Rollback();
                                        }
                                        catch (Exception err)
                                        {
                                            if (err.InnerException != null)
                                                modelErrors.Add("An error occured: " + err.InnerException.ToString());
                                            else
                                                modelErrors.Add("An error occured: " + err.Message.ToString());

                                            error = true;
                                            throw new System.InvalidOperationException("An error occured: " + err.Message.ToString());

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
                                    throw new System.InvalidOperationException("An error occured: " + err.Message.ToString());
                                }
                            }
                        }
                    }
                }
                catch (Exception err)
                {
                    string errmsg = "";
                    if (err.InnerException != null)
                        errmsg = ("An error occured: " + err.InnerException.ToString());
                    else
                        errmsg = ("An error occured: " + err.Message.ToString());
                    error = true;
                    return Json(new { success = false, errors = errmsg }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true, msg = "Data uploading was successful.", data = new { PurchaseUploadList = PurchaseUploadList } }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, msg = "Upload failed. Please try again." }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult GetPurchaseList()
        {
            List<PurchaseUpload> data = new List<PurchaseUpload>();
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
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "PurchaseOrder_GetList";
                        cmdSql.ExecuteNonQuery();
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new PurchaseUpload
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    Department = sdr["Department"].ToString(),
                                    Vendor = sdr["Vendor_Code"].ToString(),
                                    Vendor_Name = sdr["Vendor_Name"].ToString(),
                                    PO_Issued_Date = sdr["PO_Issued_Date"].ToString(),
                                    PO_Ln_No = sdr["PO_Ln_No"].ToString(),
                                    PO_No = sdr["PO_No"].ToString(),
                                    Material = sdr["Material"].ToString(),
                                    Material_Description = sdr["Material_Description"].ToString(),
                                    Unit = sdr["Unit"].ToString(),
                                    Requested_Delivery_Date = sdr["Requested_Delivery_Date"].ToString(),
                                    PO_Balance = sdr["PO_Balance"].ToString(),
                                    Cost_Center = sdr["Cost_Center"].ToString(),
                                    IsDeleted = sdr["IsDeleted"].ToString()
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
                    errmsg = "An error occured: " + err.ToString();

                return Json(new { success = false, msg = errmsg }, JsonRequestBehavior.AllowGet);
            }
            int totalrows = data.Count;
            if (!string.IsNullOrEmpty(searchValue))//filter
                data = data.Where(x =>
                    x.Department.ToLower().Contains(searchValue.ToLower()) ||
                    x.Vendor.ToLower().Contains(searchValue.ToLower()) ||
                    x.Vendor_Name.ToLower().Contains(searchValue.ToLower()) ||
                    x.PO_Issued_Date.ToLower().Contains(searchValue.ToLower()) ||
                    x.PO_Ln_No.ToLower().Contains(searchValue.ToLower()) ||
                    x.PO_No.ToLower().Contains(searchValue.ToLower()) ||
                    x.Material.ToLower().Contains(searchValue.ToLower()) ||
                    x.Material_Description.ToLower().Contains(searchValue.ToLower()) ||
                    x.Unit.ToLower().Contains(searchValue.ToLower()) ||
                    x.Requested_Delivery_Date.ToLower().Contains(searchValue.ToLower()) ||
                    x.PO_Balance.ToLower().Contains(searchValue.ToLower()) ||
                    x.Cost_Center.ToLower().Contains(searchValue.ToLower()) ||
                    x.IsDeleted.ToLower().Contains(searchValue.ToLower())
                ).ToList<PurchaseUpload>();

            int totalrowsafterfiltering = data.Count;
            if (sortDirection == "asc")
                data = data.OrderBy(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            if (sortDirection == "desc")
                data = data.OrderByDescending(x => TypeHelper.GetPropertyValue(x, sortColumnName)).ToList();

            data = data.Skip(start).Take(length).ToList<PurchaseUpload>();


            return Json(new { data = data, draw = Request["draw"], recordsTotal = totalrows, recordsFiltered = totalrowsafterfiltering }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetUOM(int MaterialID)
        {
            string UOM = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "SELECT g.[Value] from [mItemMaster] as m left join mGeneral as g on m.UOM=g.ID WHERE  m.ID=" + MaterialID;
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            if (!sdr.Read())
                            {
                                throw new Exception("No records found!");
                            }
                            else
                            {
                                UOM = sdr["Value"].ToString();
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
                    errmsg = "An error occured: " + err.ToString();

                return Json(new { success = false, msg = errmsg }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = true, data = UOM });
        }
        public ActionResult GetPOLnNo(string POID)
        {
            string POLnNo = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "SELECT top 1 m.[PO_Ln_No]+10 as Number from [pPurchaseOrderUpload] as m WHERE  m.[Po_No]='" + POID + "' and m.IsDeleted=0 order by m.[PO_Ln_No] desc";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            if (!sdr.Read())
                            {
                                POLnNo = "10";
                            }
                            else
                            {
                                POLnNo = sdr["Number"].ToString();
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
                    errmsg = "An error occured: " + err.ToString();

                return Json(new { success = false, msg = errmsg }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = true, data = POLnNo });
        }
        public ActionResult SavePurchaseOrder(PurchaseUpload PurchaseOrder)
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
                            cmdSql.CommandText = "PurchaseOrder_InsertUpdate";
                            cmdSql.Parameters.Clear();
                            cmdSql.Parameters.AddWithValue("@ID", PurchaseOrder.ID);
                            cmdSql.Parameters.AddWithValue("@Department", PurchaseOrder.Department);
                            cmdSql.Parameters.AddWithValue("@Vendor_Code", PurchaseOrder.Vendor);
                            cmdSql.Parameters.AddWithValue("@PO_Issued_Date", PurchaseOrder.PO_Issued_Date);
                            cmdSql.Parameters.AddWithValue("@PO_No", PurchaseOrder.PO_No);
                            cmdSql.Parameters.AddWithValue("@PO_Ln_No", PurchaseOrder.PO_Ln_No);
                            cmdSql.Parameters.AddWithValue("@Material", PurchaseOrder.Material.ToString());
                            cmdSql.Parameters.AddWithValue("@Unit", PurchaseOrder.Unit.ToString());
                            cmdSql.Parameters.AddWithValue("@Requested_Delivery_Date", PurchaseOrder.Requested_Delivery_Date);
                            cmdSql.Parameters.AddWithValue("@PO_Balance", PurchaseOrder.PO_Balance == "" ? 0.00 : Convert.ToDouble(PurchaseOrder.PO_Balance));
                            cmdSql.Parameters.AddWithValue("@Cost_Center", PurchaseOrder.Cost_Center);
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
        public ActionResult GetPurchaseUploadDetails(int ID)
        {
            PurchaseUpload data = new PurchaseUpload();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "PurchaseOrder_GetPurchaseUploadDetails";
                        cmdSql.Parameters.Clear();
                        cmdSql.Parameters.AddWithValue("ID", ID);
                        cmdSql.ExecuteNonQuery();
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.ID = Convert.ToInt32(sdr["ID"]);
                                data.Department = sdr["Department"].ToString();
                                data.Department_Desc = sdr["Department_Desc"].ToString();
                                data.VendorID = Convert.ToInt32(sdr["VendorID"]);
                                data.Vendor = sdr["Vendor_Code"].ToString();
                                data.Vendor_Name = sdr["Vendor_Name"].ToString();
                                data.PO_Issued_Date = sdr["PO_Issued_Date"].ToString();
                                data.PO_Ln_No = sdr["PO_Ln_No"].ToString();
                                data.PO_No = sdr["PO_No"].ToString();
                                data.Material = sdr["Material"].ToString();
                                data.Material_Description = sdr["Material_Description"].ToString();
                                data.Unit = sdr["Unit"].ToString();
                                data.PO_Balance = sdr["PO_Balance"].ToString();
                                data.Cost_Center = sdr["Cost_Center"].ToString();
                                data.Cost_Center_Desc = sdr["Cost_Center_Desc"].ToString();
                                data.IsDeleted = sdr["IsDeleted"].ToString();

                                DateTime aDate = DateTime.Parse(sdr["Requested_Delivery_Date"].ToString());
                                data.Requested_Delivery_Date = aDate.ToString("MM/dd/yyyy");
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
                    errmsg = "An error occured: " + err.ToString();

                return Json(new { success = false, msg = errmsg }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = true, data = data }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeletePO(int ID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "PurchaseOrder_Delete";

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
            return Json(new { success = true, msg = "PO was successfully deleted." });

        }
    }
}
