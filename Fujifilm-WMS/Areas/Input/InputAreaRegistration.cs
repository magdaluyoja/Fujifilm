using System.Web.Mvc;

namespace Fujifilm_WMS.Areas.Input
{
    public class InputAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Input";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "Input_default",
                "Input/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}