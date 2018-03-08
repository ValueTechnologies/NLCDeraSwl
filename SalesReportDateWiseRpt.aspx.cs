﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

namespace NLCDeraSwl
{
    public partial class SalesReportDateWiseRpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            if (txtFromDate.Text.Trim() == string.Empty || txtToDate.Text.Trim() == string.Empty)
            {
                return;
            }
            ShowReport();
        }


        private void ShowReport()
        {
            try
            {

                ReportViewer1.LocalReport.DataSources.Clear();
                DSPOS ds = new DSPOS();
                string reportPath = Server.MapPath("SalesReportDateWiseRpt.rdlc");
                DSPOSTableAdapters.usp_SalesReportDateWiseRptTableAdapter da = new DSPOSTableAdapters.usp_SalesReportDateWiseRptTableAdapter();

                da.Fill(ds.usp_SalesReportDateWiseRpt, Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text), Convert.ToInt32(HttpContext.Current.Session["ShopID"]));

                
                ReportParameter paramLogo = new ReportParameter();
                paramLogo.Name = "DateOfReport";
               
                paramLogo.Values.Add("From : " + txtFromDate.Text + " To : " +  txtToDate.Text);

                
                ReportViewer1.LocalReport.ReportPath = reportPath;
                ReportViewer1.LocalReport.SetParameters(paramLogo);

                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables["usp_SalesReportDateWiseRpt"]));

                ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex)
            {
                var a = ex.Message;
            }
        }

    }
}