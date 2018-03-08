﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace NLCDeraSwl
{
    /// <summary>
    /// Summary description for EmployeeSuspensionCS
    /// </summary>
    public class EmployeeSuspensionCS : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            MyClass Fn = new MyClass();
            var frmdata = context.Request.Form["vls"];
            string[] d = frmdata.Split('½');
            try
            {
                string id = "";

                id = Fn.ExenID(@"INSERT INTO tbl_EmployeeSuspension (Reason, SuspendedBy, SuspendOn, ContinuanceOn, EmployeeID ) VALUES ( '" + d[0] + "','" + d[1] + "' ,'" + d[2] + "','" + d[3] + "', '" + d[4] + "'); Select SCOPE_IDENTITY();");

                int NewEmpID = Convert.ToInt32(id);
                if (context.Request.Files.Count > 0 && NewEmpID > 0)
                {
                    HttpFileCollection SelectedFiles = context.Request.Files;

                    for (int i = 0; i < SelectedFiles.Count; i++)
                    {
                        // Start
                        HttpPostedFile PostedFile = SelectedFiles[i];
                        string FileName = context.Server.MapPath("~/Uploads/SuspensionLetters/" + PostedFile.FileName);
                        string Path = context.Server.MapPath("~/Uploads/SuspensionLetters/");
                        FileInfo fi = new FileInfo(FileName);

                        Fn.Exec("update tbl_EmployeeSuspension set LetterExtension = '" + fi.Extension + "' where EmpSuspensionID = " + NewEmpID);
                        PostedFile.SaveAs(Path + Convert.ToString(NewEmpID) + fi.Extension);
                    }
                }

                if (NewEmpID > 0)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(NewEmpID);
                }
            }
            catch (Exception ex)
            {

                context.Response.ContentType = "text/plain";
                context.Response.Write(ex.Message);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}