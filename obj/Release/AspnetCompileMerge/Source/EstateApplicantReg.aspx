<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageD.master" AutoEventWireup="true" CodeBehind="EstateApplicantReg.aspx.cs" Inherits="NLCDeraSwl.EstateApplicantReg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    &nbsp;
    <script type="text/javascript">
        function showimagepreview(input) {
            if (input.files && input.files[0]) {
                var filerdr = new FileReader();
                filerdr.onload = function (e) {
                    $('#imgprvw').attr('src', e.target.result);
                    $('#imgprvw').slideDown(400);
                }
                filerdr.readAsDataURL(input.files[0]);
            }
        }



        $(document).ready(function () {
            $('.heading h3').html('Applicant Registration');
            $('#txtCNICOfApplicant').mask('99999-9999999-9');



            
        });



        $('body').on({
            click: function () {
                $("*").css("cursor", "wait");
                if ($('#txtNameOfApplicant').val() == "") {
                    alert('Please enter Applicant name...');
                    return;
                }

                if ($('#txtCNICOfApplicant').val() == "") {
                    alert('Please enter CNIC...');
                    return;
                }

                if ($('#txtNTNOfApplicant').val() == "") {
                    alert('Please enter NTN...');
                    return;
                }




                var ctrlVals = "";
                $('.frmCtrl').each(function (index, element) {
                    ctrlVals += $(this).val() + '½';
                });


                //Pic File Check
                var uploadfilesP = $("#fileUpload").get(0);
                var uploadedfilesP = uploadfilesP.files;

                
                //Combine data and both file uploader data
                var fromdata = new FormData();
                fromdata.append("vls", ctrlVals);

                for (var i = 0; i < uploadedfilesP.length; i++) {
                    fromdata.append(uploadedfilesP[i].name, uploadedfilesP[i]);
                }


                var choice = {};
                choice.url = "EstateApplicantRegCS.ashx";
                choice.type = "POST";
                choice.data = fromdata;
                choice.contentType = false;
                choice.processData = false;
                choice.success = function (result) {
                    alert('Save Successfully!');
                    $("*").css("cursor", "auto");
                    $('#btnSave').attr('tag', result);


                    $('.frmCtrl').each(function (index, element) {
                        $(this).val('');
                    });


                    $('.filename').html('');
                };
                choice.error = function (err) {
                    alert(err.statusText);
                };
                $.ajax(choice);
                event.preventDefault();

            }
        }, "#btnSave");






    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row-fluid">
        <div class="span12">
            <div class="box">
                <div class="title">
                    <h4>
                        <span>Applicant Registration </span>
                    </h4>
                    <a href="dvApplicant" class="minimize">Minimize</a>
                </div>
                <div class="content" id="dvApplicant">

                    <form class="form-horizontal" action="#">
                        <div class="form-row row-fluid">
                            <div class="span6">
                                <label class="form-label span3" for="normal">Name</label>
                                <input type="text" id="txtNameOfApplicant" class="span8 frmCtrl" />
                            </div>

                            <div class="span6">
                                <label class="form-label span3" for="normal">CNIC </label>
                                <input type="text" id="txtCNICOfApplicant" class="span8 frmCtrl" />
                            </div>

                        </div>



                        <div class="form-row row-fluid">
                            <div class="span6">
                                <label class="form-label span3" for="normal">NTN No </label>
                                <input type="text" id="txtNTNOfApplicant" class="span8 frmCtrl" />
                            </div>

                            <div class="span6">
                                <label class="form-label span3" for="normal">Contact No </label>
                                <input type="text" id="txtContactOfApplicant" class="span8 frmCtrl" />
                            </div>
                        </div>

                        <div class="form-row row-fluid">
                            <div class="span6">
                                <label class="form-label span3" for="normal">Address </label>
                                <input type="text" id="txtAddressOfApplicant" class="span8 frmCtrl" />
                            </div>

                            <div class="span6">
                                <label class="form-label span3" for="normal">Photo</label>
                                <input type="file" id="fileUpload" class="span3 FUpload" onchange="showimagepreview(this);" />
                                <br />
                                <img alt="" src="" id="imgprvw" style="width: 150px; height: 150px; display:none;"  />
                                
                                

                            </div>



                        </div>

                        <div class="form-row row-fluid">
                            <div class="span6" style="margin-left: 0px;">
                                <label class="form-label span3" for="normal"></label>
                                <button type="button" id="btnSave" class="btn btn-primary span2" style="margin-left: 0px;">Save</button>
                            </div>
                        </div>



                    </form>
                </div>
            </div>
        </div>
    </div>







</asp:Content>
