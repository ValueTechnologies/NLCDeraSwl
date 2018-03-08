using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using Newtonsoft.Json;


namespace NLCDeraSwl
{
    public partial class NewStore : System.Web.UI.Page
    {
        public static MyClassPOS Fn = new MyClassPOS();
        public static MyClass Fn1 = new MyClass();
        protected void Page_Load(object sender, EventArgs e)
        {
        }


        [WebMethod]
        public static string SaveShop(string Name, string TehsilId, string GPS, string Address, string ShopAbbv, string ShopDistID)
        {
            return Fn.Data2Json("INSERT INTO tbl_Shops (ShopName, ShopTehsilID, ShopGPS, ShopAddress, ShopType,ShopAbbv, ShopDistID) VALUES ('" + Name + "','" + TehsilId + "','" + GPS + "', '" + Address + "', '" + MyClass.STORE_WAREHOUSE + "', '" + ShopAbbv + "', '" + ShopDistID + "'); Select SCOPE_IDENTITY() AS ID;");
        }

        [WebMethod]
        public static string SaveLevel(string ID, string Name)
        {
            return Fn1.Exec("usp_AddNewLevel '" + Name + "', 0, 1, 1, " + ID);
        }

        [WebMethod]
        public static string LoadShops()
        {
            return Fn.Data2Json("SELECT   ROW_NUMBER() over(order by tbl_Shops.ShopName) as Srno,  tbl_Shops.ShopID,   tbl_Shops.ShopName, tbl_Shops.ShopTehsilID, tbl_Shops.ShopGPS, tbl_Shops.ShopAddress, TblDistrict.LocName AS DistrictName, TblTehsil.LocName AS TehsilName FROM tbl_Shops INNER JOIN TblTehsil ON TblTehsil.TehsilID = tbl_Shops.ShopTehsilID INNER JOIN TblDistrict ON TblDistrict.DistrictID = TblTehsil.DistrictID WHERE ShopType = " + MyClass.STORE_WAREHOUSE);
        }
    }
}