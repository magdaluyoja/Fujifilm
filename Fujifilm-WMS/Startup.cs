using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Fujifilm_WMS.Startup))]
namespace Fujifilm_WMS
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
