namespace Fujifilm_WMS.Areas.MasterMaintenance.Controllers
{
    public class mSupplierMaster
    {
        public int ID { get; set; }
        public string SupplierCode { get; set; }
        public string SupplierName { get; set; }
        public string SupplierAbbrev { get; set; }
        public int Status { get; set; }
        public int IsDeleted { get; set; }
    }
}