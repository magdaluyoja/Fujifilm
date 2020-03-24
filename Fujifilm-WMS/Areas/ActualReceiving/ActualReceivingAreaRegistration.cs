using System.Web.Mvc;

namespace Fujifilm_WMS.Areas.ActualReceiving
{
    public class ActualReceivingAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "ActualReceiving";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "ActualReceiving_default",
                "ActualReceiving/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}