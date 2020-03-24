namespace Fujifilm_WMS.Areas.MasterMaintenance.Models
{
    public class mCostCenterMaster
    {
        public int ID { get; set; }
        public int DepartmentID { get; set; }
        public string DepartmentName { get; set; }
        public string CostCenterCode { get; set; }
        public string CostCenterName { get; set; }
        public int Status { get; set; }
        public int IsDeleted { get; set; }
    }
}