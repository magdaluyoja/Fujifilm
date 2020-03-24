using System.Web.Optimization;

namespace Fujifilm_WMS
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            string googleFonts = "https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700";
            string[] LayoutJS = new string[]
            {
                "~/Content/assets/js/bluebird.core.js",
                "~/Content/assets/plugins/jquery/jquery-3.3.1.min.js",
                "~/Content/assets/plugins/jquery-ui/jquery-ui.min.js",
                "~/Content/assets/plugins/bootstrap/js/bootstrap.bundle.min.js",
                "~/Content/assets/plugins/slimscroll/jquery.slimscroll.js",
                "~/Content/assets/plugins/js-cookie/js.cookie.js",
                "~/Content/assets/js/theme/default.min.js",
                "~/Content/assets/js/lodash.min.js",
                "~/Content/assets/js/apps.min.js",
                "~/Content/assets/js/Menu.js",
                "~/Content/assets/js/Custom.js"
            };
            string[] LayoutCSS = new string[]
            {
                "~/Content/assets/plugins/jquery-ui/jquery-ui.min.css",
                "~/Content/assets/plugins/bootstrap/css/bootstrap.min.css",
                "~/Content/assets/plugins/font-awesome/css/all.min.css",
                "~/Content/assets/plugins/animate/animate.min.css",
                "~/Content/assets/css/default/style.min.css",
                "~/Content/assets/css/default/style-responsive.min.css",
                "~/Content/assets/css/Custom.css"
            };
            string[] DataTblJS = new string[]
            {
                "~/Content/assets/plugins/DataTables/media/js/jquery.dataTables.js",
                "~/Content/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js",
                "~/Content/assets/plugins/DataTables/extensions/Responsive/js/dataTables.responsive.min.js",
                "~/Content/assets/js/demo/table-manage-fixed-header.demo.min.js",
            };
            string[] DataTblCSS = new string[]
            {
                "~/Content/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css",
                "~/Content/assets/plugins/DataTables/extensions/Responsive/css/responsive.bootstrap.min.css"
            };
            string[] TrxJS = new string[]
            {
                "~/Content/assets/plugins/iziToast/dist/js/iziToast.min.js",
                "~/Content/assets/plugins/iziModal/js/iziModal.js",
                "~/Content/assets/plugins/Parsleyjs/dist/parsley.min.js",
                "~/Content/assets/js/Classes/common/Message.js",
                "~/Content/assets/js/Classes/common/Formatter.js",
                "~/Content/assets/js/Classes/common/CustomUI.js",
                "~/Content/assets/js/Classes/common/Data.js"
            };
            string[] TrxCSS = new string[]
            {
                "~/Content/assets/plugins/iziToast/dist/css/iziToast.min.css",
                "~/Content/assets/plugins/iziModal/css/iziModal.css",
                "~/Content/assets/plugins/Parsleyjs/src/parsley.min.css"
            };
            bundles.Add(new Bundle("~/Home-CSS", googleFonts)
                   .Include(LayoutCSS)
            );

            bundles.Add(new Bundle("~/Home-JS")
                    .Include(LayoutJS)
            );
            bundles.Add(new Bundle("~/Login-CSS", googleFonts)
                   .Include(LayoutCSS)
                   .Include(TrxCSS)
            );

            bundles.Add(new Bundle("~/Login-JS")
                    .Include(LayoutJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/js/Login.js"
                    )
            );
            RegisterMasterMaintenaceBundles(bundles, LayoutJS, LayoutCSS, TrxJS, TrxCSS, DataTblJS, DataTblCSS);
            RegisterPurchaseOrderBundles(bundles, LayoutJS, LayoutCSS, TrxJS, TrxCSS, DataTblJS, DataTblCSS);
        }
        public static void RegisterMasterMaintenaceBundles(BundleCollection bundles, string[] LayoutJS, string[] LayoutCSS, string[] TrxJS, string[] TrxCSS, string[] DataTblJS, string[] DataTblCSS)
        {
            bundles.Add(new Bundle("~/UserMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include("~/Content/assets/plugins/select2/dist/css/select2.css")
            );
            bundles.Add(new Bundle("~/UserMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/MasterMaintenance/Scripts/UserMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/PageMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
            );
            bundles.Add(new Bundle("~/PageMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Areas/MasterMaintenance/Scripts/PageMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/GeneralMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/css/select2.css"
                    )
            );
            bundles.Add(new Bundle("~/GeneralMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/MasterMaintenance/Scripts/GeneralMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/ItemMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include("~/Content/assets/plugins/select2/dist/css/select2.css")
            );
            bundles.Add(new Bundle("~/ItemMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/MasterMaintenance/Scripts/ItemMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/SupplierMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include("~/Content/assets/plugins/select2/dist/css/select2.css")
            );
            bundles.Add(new Bundle("~/SupplierMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/MasterMaintenance/Scripts/SupplierMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/CostCenterMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include("~/Content/assets/plugins/select2/dist/css/select2.css")
            );
            bundles.Add(new Bundle("~/CostCenterMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/MasterMaintenance/Scripts/CostCenterMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/LocationMaster-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include("~/Content/assets/plugins/select2/dist/css/select2.css")
            );
            bundles.Add(new Bundle("~/LocationMaster-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/MasterMaintenance/Scripts/LocationMaster.js"
                    )
            );
            bundles.Add(new Bundle("~/ActualReceiving-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include("~/Content/assets/plugins/select2/dist/css/select2.css")
            );
            bundles.Add(new Bundle("~/ActualReceiving-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Areas/ActualReceiving/Scripts/Receiving.js"
                    )
            );

        }
        public static void RegisterPurchaseOrderBundles(BundleCollection bundles, string[] LayoutJS, string[] LayoutCSS, string[] TrxJS, string[] TrxCSS, string[] DataTblJS, string[] DataTblCSS)
        {
            bundles.Add(new Bundle("~/PurchaseUpload-CSS")
                    .Include(LayoutCSS)
                    .Include(DataTblCSS)
                    .Include(TrxCSS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/css/select2.css",
                        "~/Content/assets/plugins/bootstrap-datepicker/css/bootstrap-datepicker.css"
                    )
            );
            bundles.Add(new Bundle("~/PurchaseUpload-Js")
                    .Include(LayoutJS)
                    .Include(DataTblJS)
                    .Include(TrxJS)
                    .Include(
                        "~/Content/assets/plugins/select2/dist/js/select2.full.js",
                        "~/Content/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js",
                        "~/Content/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js",
                        "~/Areas/Input/Scripts/PurchaseUpload.js"
                    )
            );

        }

    }
}
