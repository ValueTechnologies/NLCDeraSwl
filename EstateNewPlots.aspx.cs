using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


namespace NLCDeraSwl
{
    public partial class EstateNewPlots : System.Web.UI.Page
    {
        public static MyClass Fn = new MyClass();

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string LoadScheme() 
        {
            return Fn.Data2Json("SELECT SchemeID, Scheme FROM tbl_EstateScheme order by Scheme");
        }


        [WebMethod]
        public static string LoadCategories(string SchemeID) 
        {
            return Fn.Data2Json("SELECT PlotCategoryID, Category FROM tbl_EstatePlotCategory where SchemeID = '" + SchemeID + "' order by Category");
        }

        [WebMethod]
        public static string LoadType()
        {
            return Fn.Data2Json("SELECT PlotTypeID, PlotType FROM tbl_EstatePlotType order by PlotType");
        }


        [WebMethod]
        public static string LoadStatus()
        {
            return Fn.Data2Json("SELECT PlotStatusID, PlotStatus FROM tbl_EstatePlotStatus order by PlotStatus");
        }


        [WebMethod]
        public static string SaveCategory(string Category, string PlotSize, string SchemeID)
        {
            return Fn.Exec("INSERT INTO tbl_EstatePlotCategory (Category, PlotSize, SchemeID) VALUES ('" + Category + "', '" + PlotSize + "', '" +SchemeID + "')");
        }


        [WebMethod]
        public static string SaveType(string Type)
        {
            return Fn.Exec("INSERT INTO tbl_EstatePlotType (PlotType) VALUES ('" + Type + "')");
        }

        [WebMethod]
        public static string SaveStatus(string Status)
        {
            return Fn.Exec("INSERT INTO tbl_EstatePlotStatus (PlotStatus) VALUES ('" + Status + "')");
        }



        [WebMethod]
        public static string SaveNewPlot(string SchemeID, string PlotNo, string PlotCategory, string KhasraNo, string PlotType, string PlotStatus, string PlotPSICPrice, string PlotDetail) 
        {
            return Fn.Exec("INSERT INTO tbl_EstateSchemePlots (SchemeID, PlotNo, PlotCategory, KhasraNo, PlotType, PlotStatus, PlotPSICPrice, PlotDetail) VALUES        ('" + SchemeID + "', '" + PlotNo + "', '" + PlotCategory + "', '" + KhasraNo + "', '" + PlotType + "', '" + PlotStatus + "', '" + PlotPSICPrice + "', '" + PlotDetail + "');");
        }


        [WebMethod]
        public static string LoadPlots(string SchemeID)
        {
            return Fn.Data2Json("SELECT row_number() over(order by tbl_EstateSchemePlots.PlotNo) as sno, tbl_EstateSchemePlots.PlotID,   tbl_EstateSchemePlots.PlotNo,  tbl_EstateSchemePlots.KhasraNo, tbl_EstateSchemePlots.PlotPSICPrice, tbl_EstateSchemePlots.PlotDetail, tbl_EstatePlotType.PlotType, tbl_EstatePlotCategory.Category, tbl_EstatePlotStatus.PlotStatus FROM            tbl_EstateSchemePlots INNER JOIN tbl_EstatePlotCategory ON tbl_EstatePlotCategory.PlotCategoryID = tbl_EstateSchemePlots.PlotCategory INNER JOIN tbl_EstatePlotType ON tbl_EstatePlotType.PlotTypeID = tbl_EstateSchemePlots.PlotType INNER JOIN tbl_EstatePlotStatus ON tbl_EstatePlotStatus.PlotStatusID = tbl_EstateSchemePlots.PlotStatus where tbl_EstateSchemePlots.SchemeID = " + SchemeID);
        }
    }
}