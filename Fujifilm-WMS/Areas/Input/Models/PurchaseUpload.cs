namespace Fujifilm_WMS.Areas.Input.Models
{
    public class PurchaseUpload
    {
        public int ID { get; set; }
        public string Department { get; set; }
        public string Department_Desc { get; set; }
        public int VendorID { get; set; }
        public string Vendor { get; set; }
        public string Vendor_Name { get; set; }
        public string PO_Issued_Date { get; set; }
        public string PO_No { get; set; }
        public string PO_Ln_No { get; set; }
        public string Material { get; set; }
        public string Material_Description { get; set; }
        public string Unit { get; set; }
        public string Requested_Delivery_Date { get; set; }
        public string PO_Balance { get; set; }
        public string Cost_Center { get; set; }
        public string Cost_Center_Desc { get; set; }
        public string IsDeleted { get; set; }
    }
}
