using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fujifilm_WMS.Areas.MasterMaintenance.Models
{
    public class mItemDetails
    {
        public int ID { get; set; }
        public string PartNumber { get; set; }
        public string PartName { get; set; }
        public string Model { get; set; }
        public string ModelValue { get; set; }
        public string Category { get; set; }
        public string CategoryValue { get; set; }
        public string UOM { get; set; }
        public string UOMValue { get; set; }
        public int Status { get; set; }
        public int IsDeleted { get; set; }
    }
}