namespace Fujifilm_WMS.Areas.MasterMaintenance.Models
{
    public class mItemMaster
    {
        public int ID { get; set; }
        public string PartNumber { get; set; }
        public string PartName { get; set; }
        public string Model { get; set; }
        public string Category { get; set; }
        public string UOM { get; set; }
        public int Status { get; set; }
        public int IsDeleted { get; set; }

    }
}