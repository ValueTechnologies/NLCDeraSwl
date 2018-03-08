using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NLCDeraSwl
{
    public partial class StockRegisterRpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSubCategory.DataBind();
        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            ShowReport();
        }


        private void ShowReport()
        {
            try
            {

                ReportViewer1.LocalReport.DataSources.Clear();
                DSPOS ds = new DSPOS();
                string reportPath = Server.MapPath("StockRegisterRpt.rdlc");
                DSPOSTableAdapters.usp_StockRegisterCatwiseRptTableAdapter da = new DSPOSTableAdapters.usp_StockRegisterCatwiseRptTableAdapter();

                da.Fill(ds.usp_StockRegisterCatwiseRpt, Convert.ToInt32(ddlCategory.SelectedValue), Convert.ToInt32(ddlSubCategory.SelectedValue), txtSearchName.Text.Trim());
                
                ReportViewer1.LocalReport.ReportPath = reportPath;

                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables["usp_StockRegisterCatwiseRpt"]));

                ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception)
            {

            }
        }




    }
}