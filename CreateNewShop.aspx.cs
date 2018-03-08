using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


namespace NLCDeraSwl
{
    public partial class CreateNewShop : System.Web.UI.Page
    {
        public static MyClassPOS Fn = new MyClassPOS();
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string SaveShop(string Name, string TehsilId, string GPS, string Address, string ShopAbbv, string ShopDistID)
        {
            return Fn.Exec("INSERT INTO tbl_Shops (ShopName, ShopTehsilID, ShopGPS, ShopAddress, ShopType,ShopAbbv, ShopDistID) VALUES ('" + Name + "','" + TehsilId + "','" + GPS + "', '" + Address + "', '" + MyClass.POS + "', '" + ShopAbbv + "', '" + ShopDistID + "'); Select SCOPE_IDENTITY();");
        }


        [WebMethod]
        public static string LoadShops()
        {
            return Fn.Data2Json("SELECT   ROW_NUMBER() over(order by tbl_Shops.ShopName) as Srno,  tbl_Shops.ShopID,   tbl_Shops.ShopName, tbl_Shops.ShopTehsilID, tbl_Shops.ShopGPS, tbl_Shops.ShopAddress, TblDistrict.LocName AS DistrictName, TblTehsil.LocName AS TehsilName FROM tbl_Shops INNER JOIN TblTehsil ON TblTehsil.TehsilID = tbl_Shops.ShopTehsilID INNER JOIN TblDistrict ON TblDistrict.DistrictID = TblTehsil.DistrictID WHERE ShopType = " + MyClass.STORE_WAREHOUSE);
        }
    }
}