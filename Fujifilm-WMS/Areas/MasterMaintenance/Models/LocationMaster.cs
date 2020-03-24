namespace Fujifilm_WMS.Areas.MasterMaintenance.Models
{
    public class LocationMaster
    {
        public int ID { get; set; }
        public string Area { get; set; }
        public string Position { get; set; }

        public int X { get; set; }
        public int Y { get; set; }
        public int Z { get; set; }

        public decimal PalletCapacity { get; set; }
        public decimal BoxCapacity { get; set; }
        public int Status { get; set; }

        public int IsDeleted { get; set; }

    }
}