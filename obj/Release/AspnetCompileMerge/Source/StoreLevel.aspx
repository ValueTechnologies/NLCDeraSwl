<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageD.master" AutoEventWireup="true" CodeBehind="StoreLevel.aspx.cs" Inherits="NLCDeraSwl.StoreLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    &nbsp;
    
    <script type="text/javascript" src="js/jquery.treeview.js"></script>
    <link href="css/jquery.treeview.css" rel="stylesheet" />
    <link href="css/screen.css" rel="stylesheet" />


    <script type="text/javascript">

        $(document).ready(function () {
            $('.heading h3').html('Store Levels');
            $('#dvAddNewHead').dialog({ autoOpen: false, width: "45%", modal: true });
            $('#dvEditHead').dialog({ autoOpen: false, width: "45%", modal: true });

            LoadParents();
            function LoadParents() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "StoreLevel.aspx/DisplayTree",
                    data: "{'parent' : '0'}",
                    success: function (response) {
                        try {
                            second(response.d);
                            SetColors();

                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });
            }

            function second(Out) {
                $('#tree').html(Out);
                $("#tree").treeview({
                    collapsed: false,
                    animated: "medium",
                    control: "#sidetreecontrol",
                    persist: "location"
                });
            }

            $('#txtNewHeadName').keypress(function (e) {
                if (e.which == 13) {
                    $("#btnSaveNewHead").click();
                }
            });

            $('#txtEditHeadName').keypress(function (e) {
                if (e.which == 13) {
                    $("#btnUpdateHead").click();
                }
            });

            function SetColors() {
                $('li[lvl=1]').each(function (index, element) {
                    $(this).css('color', 'red');
                });
                $('li[lvl = 2]').each(function (index, element) {
                    $(this).css('color', 'green');
                });
                $('li[lvl = 3]').each(function (index, element) {
                    $(this).css('color', 'brown');
                });
                $('li[lvl = 4]').each(function (index, element) {
                    $(this).css('color', 'blue');
                });
                $('li[lvl = 5]').each(function (index, element) {
                    $(this).css('color', 'orange');
                });
                $('li[lvl = 6]').each(function (index, element) {
                    $(this).css('color', 'black');
                });
            }

            $('.tree1 li').live('hover', function () {
                var tag = $(this).attr('tag');
                var ed = $('.viz[tag=' + tag + ']');
                ed.fadeToggle(500);
                // alertR('show123');

            });


            $('#btnSaveNewHead').bind('click', function () {
                if ($('#txtNewHeadCode').val().trim() == "") {
                    alert('Please enter code...');
                    return;
                }
                if ($('#txtNewHeadName').val().trim() == "") {
                    alert('Please enter head name...');
                    return;
                }


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "StoreLevel.aspx/SaveNewHead",
                    data: "{ 'Parent' : '" + $('#btnSaveNewHead').attr('tag') + "', 'Name' : '" + $('#txtNewHeadName').val().trim() + "', 'HeadType' : '" + $('#ddlNewHeadType').val() + "'}",
                    success: function (response) {
                        LoadParents();
                        $('#dvAddNewHead').dialog('close');
                        $('#btnSaveNewHead').removeAttr('tag');
                        $('#txtNewHeadCode').removeAttr('tag');
                        $('#txtNewHeadCode').val('');
                        $('#txtNewHeadName').val('');

                    }
                });
            });


            $('#btnUpdateHead').bind('click', function () {
                if ($('#txtEditHeadName').val().trim() == "") {
                    alert('Please enter Head Name...');
                    return;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "StoreLevel.aspx/UpdateHead",
                    data: "{ 'ID' : '" + $('#btnUpdateHead').attr('tag') + "', 'Name' : '" + $('#txtEditHeadName').val().trim() + "', 'HeadType' : '" + $('#ddlEditHeadType').val() + "'}",
                    success: function (response) {
                        LoadParents();
                        $('#dvEditHead').dialog('close');
                        $('#txtEditHeadName').val('');

                    }
                });
            });

            $('#btnSaveNewParent').bind('click', function () {
                $('#dvAddNewHead').dialog('open');
                $('#btnSaveNewHead').attr('tag', $(this).attr('tag'));
                $('#txtNewHeadCode').attr('tag', $(this).attr('level'));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "StoreLevel.aspx/GetNewCode",
                    data: "{ 'ID' : '" + $(this).attr('tag') + "'}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d);
                        $('#txtNewHeadCode').val(jData[0].NewCode);
                    }
                });
            });


        });
        //end ready

        $('body').on({
            click: function () {
                $('#dvAddNewHead').dialog('open');
                $('#btnSaveNewHead').attr('tag', $(this).attr('tag'));
                $('#txtNewHeadCode').attr('tag', $(this).attr('level'));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "StoreLevel.aspx/GetNewCode",
                    data: "{ 'ID' : '" + $(this).attr('tag') + "'}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d);
                        $('#txtNewHeadCode').val(jData[0].NewCode);
                    }
                });
            }

        }, '.clsAddNewNode');




        $('body').on({
            click: function () {
                $('#dvEditHead').dialog('open');
                $('#btnUpdateHead').attr('tag', $(this).attr('tag'));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "StoreLevel.aspx/GetHeadType",
                    data: "{ 'ID' : '" + $(this).attr('tag') + "'}",
                    success: function (response) {
                        var jData = $.parseJSON(response.d);
                        $('#ddlEditHeadType').val(jData[0].LevelType);
                        $("#ddlEditHeadType").prev().html($("#ddlEditHeadType option:selected").text());
                        $('#txtEditHeadCode').val(jData[0].Code);
                        $('#txtEditHeadName').val(jData[0].Name);
                    }
                });
            }
        }, '.clsEditNode');




    </script>

    <style type="text/css">
        .clsAddNewNode {
            width: 15px;
        }

        .clsEditNode {
            width: 15px;
            margin-left: 15px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="dvAddNewHead" title="Add New Store Head">
        <table>
            <tr>
                <td style="width: 70px;">Head Code
                </td>
                <td>
                    <input type="text" id="txtNewHeadCode" disabled="disabled" />
                </td>
            </tr>
            <tr>
                <td>Head name
                </td>
                <td>
                    <input type="text" id="txtNewHeadName" />
                </td>
            </tr>
            <tr>
                <td>Head Type
                </td>
                <td>
                    <div>
                        <select id="ddlNewHeadType">
                            <option value="1">Head Level</option>
                            <option value="2">Entry Level</option>
                        </select>

                    </div>

                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <div style="margin-top: 10px;">
                        <button type="button" class="btn btn-primary" id="btnSaveNewHead">Save</button>
                    </div>

                </td>
            </tr>
        </table>
    </div>


    <div id="dvEditHead" title="Edit Account Head">
        <table>
            <tr>
                <td style="width: 70px;">Head Code
                </td>
                <td>
                    <input type="text" id="txtEditHeadCode" disabled="disabled" />
                </td>
            </tr>
            <tr>
                <td>Head name
                </td>
                <td>
                    <input type="text" id="txtEditHeadName" />
                </td>
            </tr>
            <tr>
                <td>Head Type
                </td>
                <td>
                    <div>
                        <select id="ddlEditHeadType">
                            <option value="1">Head Level</option>
                            <option value="2">Entry Level</option>
                        </select>

                    </div>

                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <div style="margin-top: 10px;">
                        <button type="button" class="btn btn-primary" id="btnUpdateHead">Save</button>
                    </div>

                </td>
            </tr>
        </table>
    </div>


    <div style="margin-top: 10px; float:right; margin-bottom:3px; display:none;">
         <button type="button" class="btn btn-primary" id="btnSaveNewParent" tag="0">Add New Parent</button>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <div class="box">
                <div class="title">
                    <h4>
                        <span>Store Level</span>
                    </h4>
                </div>
                <div class="content">

                    <form class="form-horizontal" action="#">
                        <div style="margin-left: 2%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 70%;">
                                        <div id="sidetree">
                                            <div class="treeheader">&nbsp;</div>
                                            <div id="sidetreecontrol"><a href="?#">Collapse All</a> | <a href="?#">Expand All</a></div>
                                            <ul id="tree" class="tree1">
                                            </ul>
                                        </div>
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>


                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
