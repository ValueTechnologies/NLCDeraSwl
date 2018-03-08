using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


namespace NLCDeraSwl
{
    public partial class ViewPurchaseOrders : System.Web.UI.Page
    {
        private static MyClassPOS Fn = new MyClassPOS();
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string SearchPOs(string fromDate, string toDate)
        {
            return Fn.Data2Json("usp_GetPurchaseOrdersFromDate '" + fromDate + "', '" + toDate + "','" + Convert.ToInt32(HttpContext.Current.Session["ShopID"]) + "'");
        }
    }
}