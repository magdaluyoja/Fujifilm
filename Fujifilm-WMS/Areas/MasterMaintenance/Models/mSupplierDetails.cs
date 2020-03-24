using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fujifilm_WMS.Areas.MasterMaintenance.Models
{
    public class mSupplierDetails
    {
        public int ID { get; set; }
        public string SupplierCode { get; set; }
        public string SupplierName { get; set; }
        public string SupplierAbbrev { get; set; }
        public int Status { get; set; }
        public int IsDeleted { get; set; }
    }
}