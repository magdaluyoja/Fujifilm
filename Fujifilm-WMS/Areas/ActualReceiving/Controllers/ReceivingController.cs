using Fujifilm_WMS.Areas.ActualReceiving.Models;
using Fujifilm_WMS.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;
namespace Fujifilm_WMS.Areas.ActualReceiving.Controllers
{
    public class ReceivingController : Controller
    {
        Security ph = new Security();
        DataHelper dataHelper = new DataHelper();
        List<string> modelErrors = new List<string>();
        bool error = false;
        string errmsg = "";
        // GET: ActualReceiving/Receiving
        public ActionResult Index()
        {
            return View("Receiving");
        }
        public ActionResult GetSupplierName(string ID)
        {
            string SupplierName = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "select b.SupplierName as VendorName from pPurchaseOrderUpload a left join mSupplier b on a.Vendor_Code=b.ID WHERE a.PO_No='" + ID + "' and a.IsDeleted=0";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                SupplierName = sdr["VendorName"].ToString();

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
            return Json(new { success = true, data = SupplierName });
        }
        public ActionResult GetOrderReceivingList(string PONo)
        {
            ArrayList data = new ArrayList();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.StoredProcedure;
                        cmdSql.CommandText = "Receiving_GetPOItems";
                        cmdSql.Parameters.Clear();
                        cmdSql.Parameters.AddWithValue("@PONO", PONo);
                        cmdSql.ExecuteNonQuery();
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    PO_Issued_Date = sdr["PO_Issued_Date"].ToString(),
                                    PO_Ln_No = sdr["PO_Ln_No"].ToString(),
                                    PO_No = sdr["PO_No"].ToString(),
                                    Material = sdr["Material"].ToString(),
                                    Material_Description = sdr["Material_Description"].ToString(),
                                    Unit = sdr["Unit"].ToString(),
                                    Requested_Delivery_Date = sdr["Requested_Delivery_Date"].ToString(),
                                    PO_Balance = sdr["PO_Balance"].ToString(),
                                    Cost_Center = sdr["Cost_Center"].ToString(),
                                    HasHistory = sdr["HasHistory"].ToString(),
                                    Actual_Qty = 0,
                                    Received_Date = "",
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
            return Json(new { success = true, data = data }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SavePOReceiving(List<Receiving> POItemsRec)
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
                        SqlTransaction transaction;
                        transaction = conn.BeginTransaction("Save_OrderQueue");
                        foreach (Receiving ItemsRec in POItemsRec)
                        {
                            using (SqlCommand cmdSql = conn.CreateCommand())
                            {
                                cmdSql.Connection = conn;
                                cmdSql.Transaction = transaction;
                                cmdSql.CommandType = CommandType.StoredProcedure;
                                cmdSql.CommandText = "Receiving_POItemsInsertUpdate";
                                cmdSql.Parameters.Clear();
                                //cmdSql.Parameters.AddWithValue("@ID", "");
                                cmdSql.Parameters.AddWithValue("@PONo", ItemsRec.PONo);
                                cmdSql.Parameters.AddWithValue("@PO_Ln_No", ItemsRec.PO_Ln_No);
                                cmdSql.Parameters.AddWithValue("@Actual_Qty", ItemsRec.Actual_Qty);
                                cmdSql.Parameters.AddWithValue("@Received_Date", ItemsRec.Received_Date);
                                cmdSql.Parameters.AddWithValue("@CreateID", Session["Username"]);
                                cmdSql.ExecuteNonQuery();
                            }
                        }
                        transaction.Commit();
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
        public ActionResult ViewReceivingHistory(string PONo, string PO_Ln_No)
        {
            ArrayList data = new ArrayList();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))

                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        cmdSql.CommandType = CommandType.Text;
                        cmdSql.CommandText = "SELECT * FROM [pActualReceivingDetails] WHERE IsDeleted=0 AND PONo='" + PONo + "' AND [PO_Ln_No]='" + PO_Ln_No + "'";
                        using (SqlDataReader sdr = cmdSql.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    PONo = sdr["PONo"].ToString(),
                                    PO_Ln_No = sdr["PO_Ln_No"].ToString(),
                                    PartNumber = sdr["PartNumber"].ToString(),
                                    Actual_Qty = sdr["Actual_Qty"].ToString(),
                                    Received_Date = sdr["Received_Date"].ToString(),
                                    IsDeleted = sdr["IsDeleted"].ToString(),
                                    CreateID = sdr["CreateID"].ToString(),
                                    CreateDate = sdr["CreateDate"].ToString(),
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
            return Json(new { success = true, data = data }, JsonRequestBehavior.AllowGet);
        }
    }
}
