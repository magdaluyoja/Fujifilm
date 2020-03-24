using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fujifilm_WMS.Areas.PurchaseOrder.Controllers
{
    public class PurchaseOrderUploadController : Controller
    {
        // GET: PurchaseOrder/PurchaseOrderUpload
        public ActionResult Index()
        {
            return View("PurchaseOrderUpload");
        }
    }
}