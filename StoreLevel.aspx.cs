using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;


namespace NLCDeraSwl
{
    public partial class StoreLevel : System.Web.UI.Page
    {
        public static MyClass Fn = new MyClass();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string DisplayTree(string parent) 
        {
            DBManagerPSICMisc dbMan = new DBManagerPSICMisc();
            return dbMan.GetStoreTree(parent);

        }

        [WebMethod]
        public static string SaveNewHead(string Parent, string Name, string HeadType)
        {
            return Fn.Exec("usp_AddNewLevel '" + Name + "', " + Parent + ", " + HeadType + ", 1, 0");
        }

        [WebMethod]
        public static string GetNewCode(string ID)
        {
            return Fn.Data2Json("Select dbo.fn_getNewCode(" + ID + ",(dbo.fn_getLevelDepth(" + ID + "))) AS NewCode");
        }

        [WebMethod]
        public static string GetHeadType(string ID) 
        {
            return Fn.Data2Json("select Name, Code, LevelType from tbl_Level where ID = " + ID);
        }


        [WebMethod]
        public static string UpdateHead(string ID, string Name, string HeadType) 
        {
            return Fn.Exec("UPDATE tbl_Level SET Name = '" + Name + "', LevelType = '" + HeadType + "' where ID = " + ID);
        }
    }
}