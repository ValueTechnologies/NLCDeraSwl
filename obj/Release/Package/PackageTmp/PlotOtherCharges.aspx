﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageD.master" AutoEventWireup="true" CodeBehind="PlotOtherCharges.aspx.cs" Inherits="NLCDeraSwl.PlotOtherCharges" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    &nbsp;

    <script type="text/javascript">
        $(document).ready(function () {
            $('.heading h3').html('Plot Charges');
            $('#txtPaymentDate').datepicker({ dateFormat: 'dd - MM - yy', changeYear: true, changeMonth: true });


            $('#dvCharges').dialog({ autoOpen: false, width: '50%', modal: true });
            $('#btnAddNewChaeges').bind('click', function () {
                $('#dvCharges').dialog("open");
            });


            LoadScheme();
            LoadType();
            LoadPlotChargesType();


            function LoadScheme() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "EstateNewPlots.aspx/LoadScheme",
                    data: "{}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d), Out = "";

                        $.each(jData, function (i, item) {
                            Out = Out + '<option value="' + item.SchemeID + '"> ' + item.Scheme + ' </value>';
                        });
                        $('#ddlScheme').html(Out);
                        $('#ddlScheme').prev().html($('#ddlScheme option:selected').text());
                        LoadCategories();
                        LoadPlots();
                    }
                });
            }

            $('#ddlScheme').bind('change', function () {
                LoadCategories();
                LoadPlots();
            });

            function LoadCategories() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "EstateNewPlots.aspx/LoadCategories",
                    data: "{ 'SchemeID' : '" + $('#ddlScheme').val() + "'}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d), Out = "";

                        $.each(jData, function (i, item) {
                            Out = Out + '<option value="' + item.PlotCategoryID + '"> ' + item.Category + ' </value>';
                        });
                        $('#ddlCategory').html(Out);
                        $('#ddlCategory').prev().html($('#ddlCategory option:selected').text());
                    }
                });
            }


            function LoadPlots() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "EstatePlotBalloting.aspx/LoadPlots",
                    data: "{ 'SchemeID' : '" + $('#ddlScheme').val() + "'}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d), Out = "";

                        $.each(jData, function (i, item) {
                            Out = Out + '<option value="' + item.PlotID + '"> ' + item.PlotNo + ' </value>';
                        });
                        $('#ddlPlotNo').html(Out);
                        $('#ddlPlotNo').prev().html($('#ddlPlotNo option:selected').text());


                    }
                });
            }


            function LoadType() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "EstatePlotBalloting.aspx/LoadType",
                    data: "{}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d), Out = "";

                        $.each(jData, function (i, item) {
                            Out = Out + '<option value="' + item.PlotTypeID + '"> ' + item.PlotType + ' </value>';
                        });
                        $('#ddlType').html(Out);
                        $('#ddlType').prev().html($('#ddlType option:selected').text());
                    }
                });
            }


            function LoadPlotChargesType() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "PlotOtherCharges.aspx/PlotCharges",
                    data: "{}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d), Out = "";

                        $.each(jData, function (i, item) {
                            Out = Out + '<option value="' + item.PlotChargesTypeID + '"> ' + item.PlotChagesTitle + ' </value>';
                        });
                        $('#ddlPlotCharges').html(Out);
                        $('#ddlPlotCharges').prev().html($('#ddlPlotCharges option:selected').text());
                    }
                });
            }


            $('#btnSearch').bind('click', SearchPlot);


            $('#btnSaveNewCharges').bind('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "PlotOtherCharges.aspx/SaveNewPlotChargesType",
                    data: "{ 'Title' : '" + $('#txtNewCharges').val() + "'}",
                    success: function (response) {
                        $('#dvCharges').dialog("close");
                        $('#txtNewCharges').val('');
                        LoadPlotChargesType();
                    }
                });
            });


            $('#btnAddCharges').bind('click', function () {
                if ($('#btnSave').attr('tag') == undefined) {
                    alert('Please first Select Plot...');
                    return;
                }

                var str = "";
                str = '<tr><td tag="' + $('#ddlPlotCharges').val() + '"> ' + $('#ddlPlotCharges').prev().html() + '</td> <td> ' + $('#txtAmount').val() + '</td><td> ' + $('#txtPaymentDate').val() + ' </td><td> <img class="clsCharges" src="Images/cross_circle.png"> </td></tr>';
                $('#tbCharges').append(str);
                $('#txtAmount').val('');
                $('#txtPaymentDate').val('');
                $('#tbCharges').focus();
            });


            $('#btnSave').bind('click', function () {
                if ($('#btnSave').attr('tag') == undefined) {
                    alert('Please first select plot...');
                    return;
                }
                var Title = [], Amount = [], PaymentDate = [];
                $('.clsCharges').each(function (i, item) {
                    PaymentDate[i] = $(this).parent().prev().html();
                    Amount[i] = $(this).parent().prev().prev().html();
                    Title[i] = $(this).parent().prev().prev().prev().attr('tag');
                });


                for (var index = 0; index < Title.length; index++) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        url: "PlotOtherCharges.aspx/SavePlotCharges",
                        data: "{ 'Title' : '" + Title[index] + "', 'Amount' : '" + Amount[index] + "' , 'PaymentDate' : '" + PaymentDate[index] + "' , 'PlotID' : '" + $('#btnSave').attr('tag') + "'}",
                        success: function (response) {
                            $('#tbCharges tbody').html('');
                        }
                    });
                }

                alert('Save Successfully!');
            });


        });
        //end Ready

        $('body').on({
            click: function () {
                $(this).parent().parent().remove();
            }
        }, '.clsCharges');


        function SearchPlot() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "EstatePlotAllocation.aspx/SearchPlots",
                data: "{ 'SchemeID' : '" + $('#ddlScheme').val() + "', 'CategoryID' : '" + $('#ddlCategory').val() + "','PlotID' : '" + $('#ddlPlotNo').val() + "','PlotType' : '" + $('#ddlType').val() + "'}",
                success: function (response) {
                    var jData = $.parseJSON(response.d), Out = "";

                    $.each(jData, function (i, item) {
                        Out = Out + '<tr><td> ' + item.Srno + '</td> <td> ' + item.PlotNo + '</td><td> ' + item.Category + '</td><td> ' + item.KhasraNo + '</td><td> ' + item.PlotType + '</td><td> ' + item.PlotStatus + '</td><td> <button type="button" CID="' + item.PlotCategoryID + '" tag="' + item.PlotID + '" class="clsSelectingPlot btn btn-link">Select </button>      </td></tr>';
                    });

                    $('#tbSearchedPlots tbody').html(Out);
                }
            });
        }


        $('body').on({
            click: function () {
                $('#lblPlotNo').html($(this).parent().prev().prev().prev().prev().prev().html());
                $('#lblPlotCategory').html($(this).parent().prev().prev().prev().prev().html());
                $('#lblKhasraNo').html($(this).parent().prev().prev().prev().html());
                $('#lblType').html($(this).parent().prev().prev().html());
                $(this).parent().prev().prev().prev().prev().prev().prev().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $(this).parent().prev().prev().prev().prev().prev().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $(this).parent().prev().prev().prev().prev().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $(this).parent().prev().prev().prev().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $(this).parent().prev().prev().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $(this).parent().prev().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $(this).parent().css('background-color', 'rgba(40, 239, 15, 0.35)');
                $('#btnSave').attr('tag', $(this).attr('tag'));
                $(this).attr('disabled', 'disabled');
                $('#btnSelectCandidate').removeAttr('disabled');

            }
        }, '.clsSelectingPlot');




    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="dvCharges" title="Add New Charges">
        <table>
            <tr>
                <td style="width: 100px;">New Charges Type 
                </td>
                <td>
                    <input id="txtNewCharges" type="text" class="span5" />
                </td>
            </tr>

            <tr>
                <td style="width: 100px;"></td>
                <td>
                    <button type="button" class="btn btn-primary" id="btnSaveNewCharges">Save</button>
                </td>
            </tr>
        </table>
    </div>

    <div class="row-fluid">
        <div class="span12">
            <div class="box">
                <div class="title">
                    <h4>
                        <span>Search Plot </span>
                    </h4>
                    <a href="dvSearchPlotAllocation" class="minimize">Minimize</a>
                </div>
                <div class="content" id="dvSearchPlotAllocation">

                    <form class="form-horizontal" action="#">
                        <div class="form-row row-fluid">
                            <div class="span6">
                                <label class="form-label span3" for="normal">Scheme </label>
                                <div class="span8" style="margin-left: 0px;">
                                    <select id="ddlScheme">
                                    </select>
                                </div>
                            </div>

                            <div class="span6">
                                <label class="form-label span3" for="normal">Category </label>
                                <div class="span8" style="margin-left: 0px;">
                                    <select id="ddlCategory">
                                    </select>
                                </div>
                            </div>

                        </div>



                        <div class="form-row row-fluid">
                            <div class="span6">
                                <label class="form-label span3" for="normal">Plot No. </label>
                                <div class="span8" style="margin-left: 0px;">
                                    <select id="ddlPlotNo">
                                    </select>
                                </div>
                            </div>
                            <div class="span6">
                                <label class="form-label span3" for="normal">Type </label>
                                <div class="span8" style="margin-left: 0px;">
                                    <select id="ddlType">
                                    </select>
                                </div>
                            </div>
                        </div>




                        <div class="form-row row-fluid">
                            <div class="span6" style="margin-left: 0px;">
                                <label class="form-label span3" for="normal"></label>
                                <button type="button" id="btnSearch" class="btn btn-primary span2" style="margin-left: 0px;">Search</button>
                            </div>
                        </div>


                        <div class="form-row row-fluid">
                            <div class="span12" style="margin-left: 0px;">
                                <table class="responsive table table-striped table-bordered table-condensed" id="tbSearchedPlots">
                                    <thead>
                                        <tr>
                                            <th>Sr.No
                                            </th>
                                            <th>Plot #
                                            </th>
                                            <th>Category
                                            </th>
                                            <th>Khasra No
                                            </th>
                                            <th>Type
                                            </th>
                                            <th>Status
                                            </th>
                                            <th>Select
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>





    <div class="row-fluid">
        <div class="span12">
            <div class="box">
                <div class="title">
                    <h4>
                        <span>Plot Charges </span>
                    </h4>
                    <a href="dvNewPlotAllocation" class="minimize">Minimize</a>
                </div>
                <div class="content" id="dvNewPlotAllocation">

                    <form class="form-horizontal" action="#">

                        <div class="form-row row-fluid">
                            <div class="span12">

                                <div class="form-row row-fluid">
                                    <div class="span6">
                                        <label class="form-label span4" for="normal" style="font-weight: bold;">Plot #</label>
                                        <label class="form-label span6" for="normal" id="lblPlotNo">.................</label>
                                    </div>
                                    <div class="span6">
                                        <label class="form-label span4" for="normal" style="font-weight: bold;">Plot Category</label>
                                        <label class="form-label span6" for="normal" id="lblPlotCategory">.................</label>
                                    </div>
                                </div>

                                <div class="form-row row-fluid">
                                    <div class="span6">
                                        <label class="form-label span4" for="normal" style="font-weight: bold;">Khasra No</label>
                                        <label class="form-label span6" for="normal" id="lblKhasraNo">.................</label>
                                    </div>
                                    <div class="span6">
                                        <label class="form-label span4" for="normal" style="font-weight: bold;">Type</label>
                                        <label class="form-label span6" for="normal" id="lblType">.................</label>
                                    </div>
                                </div>
                            </div>
                        </div>




                        <div class="form-row row-fluid">
                            <div class="span12">
                                <div class="span10" style="background-color: lightgray; padding: 5px; text-align: center; border-radius: 7px; margin-top: 20px; margin-bottom: 30px;">
                                    <h3>Plot Charges    
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <div class="form-row row-fluid">
                            <div class="span12">
                                <label class="form-label span2" for="normal">Title</label>
                                <div class="span4" style="margin-left: 0px;">
                                    <select id="ddlPlotCharges">
                                    </select>
                                </div>
                                <button type="button" class="btn btn-info span2" id="btnAddNewChaeges">Add New</button>
                            </div>

                        </div>
                        <div class="form-row row-fluid">
                            <div class="span12">
                                <label class="form-label span2" for="normal">Amount</label>
                                <input type="text" class="span4" id="txtAmount" />
                            </div>
                        </div>


                        <div class="form-row row-fluid">
                            <div class="span12">
                                <label class="form-label span2" for="normal">Payment Date</label>
                                <input type="text" class="span4" id="txtPaymentDate" />
                            </div>
                        </div>



                        <div class="form-row row-fluid">
                            <div class="span12">
                                <label class="form-label span2" for="normal"></label>
                                <div style="margin-left: 0px;">
                                    <button type="button" class="btn btn-info span2" id="btnAddCharges">Add</button>
                                </div>

                            </div>

                        </div>


                        <div class="form-row row-fluid">
                            <div class="span12">
                                <table  id="tbCharges" class="responsive table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th>Title
                                            </th>
                                            <th>Amount
                                            </th>
                                            <th>Payment Date
                                            </th>
                                            <th>Cancel
                                            </th>
                                        </tr>
                                    </thead>
                                </table>

                            </div>
                        </div>


                        <div class="form-row row-fluid">
                            <div class="span12">
                                <label class="form-label span2" for="normal"></label>
                                <button type="button" class="btn btn-primary" id="btnSave">Save</button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
