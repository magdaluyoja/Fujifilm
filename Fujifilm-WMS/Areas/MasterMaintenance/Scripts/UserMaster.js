﻿"use strict";
(function () {
    var User = $D();
    var tblUser = "";
    var Username = "";
    var ID = 0;

    $(document).ready(function () {
        drawDatatables();
        $("#btnAddUser").click(function () {
            $("#mdlUser").modal("show");
        });
        $("#Username").change(function () {
            validateUsername(this);
        });
        $("#Email").change(function () {
            validateEmail(this);
        });
        $('#btnCancelUser').click(function () {
            cancelUserForm();
            CUI.setDatatableMaxHeight();
        });
        $("#btnGeneratePassword").click(function () {
            $("#Password").val(generatePassword());
            User.parsleyValidate("frmUser");
        });
        $("#frmUser").submit(function (e) {
            e.preventDefault();
            saveUser();
        });
        $('#tblUser tbody').on('click', 'tr', function () {
            dis_se_lectUserRow($(this));
        });
        $('#btnEditUser').click(function () {
            editUser();
        });
        $('#btnDeleteUser').click(function () {
            User.msg = "Are you sure you want to delete this User?";
            User.confirmAction().then(function (approve) {
                if (approve)
                    deleteUser();
            });
        });
        $('#btnUserAccess').click(function () {
            getUserAccess();
        });
        $("#mdlBodyUserAccess").on("click", ".parentMenu", function () {
            var childClass = $(this).data("childclass");
            $("." + childClass).prop("checked", $(this).is(":checked"));
        });
        $("#mdlBodyUserAccess").on("click", ".subMenu", function () {
            var parentID = $(this).data("parent");
            var myClass = $(this).data("myclass");
            $("#" + parentID).prop("checked", $("." + myClass + ":checked").length);
        });
        $("#btnSaveUserAccess").click(function () {
            saveUserAccess();
        });

        //#Special Events
        tblUser.on('draw.dt', function () {
            CUI.dataTableID = "#tblUser";
            CUI.setDatatableMaxHeight();
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        $('#mdlUser').on('shown.bs.modal', function (e) {
            $('#Department').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'ID',
                            text: 'Value',
                            table: 'mGeneral',
                            db: 'Fujifilm_WMS',
                            condition: ' AND TypeID=1 ',
                            display: 'id&text',
                        };
                    },
                },
                placeholder: '--Please Select--',
            })
        })
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            if (!$.fn.DataTable.isDataTable('#tblUser')) {
                tblUser = $('#tblUser').DataTable({
                    processing: true,
                    serverSide: true,
                    "order": [[0, "asc"]],
                    "pageLength": 25,
                    "ajax": {
                        "url": "/MasterMaintenance/UserMaster/GetUserList",
                        "type": "POST",
                        "datatype": "json",
                    },
                    responsive: true,
                    dataSrc: "data",
                    columns: [
                        { title: "Username", data: "Username" },
                        { title: "Email", data: 'Email' },
                        {
                            title: "Name", data: 'Email', render: function (data, type, row, meta) {
                                return row.FirstName + " " + row.LastName
                            }
                        },
                        { title: "Department", data: 'Department' },
                        {
                            title: "Post Function/Approval", data: 'PostFunction_Approver', render: function (data) {
                                return data == 0 ? "No" : "Yes";
                            }
                        },
                        { title: "Role", data: 'Role' },
                    ],
                    "createdRow": function (row, data, dataIndex) {
                        $(row).attr('data-id', data.ID);
                        $(row).attr('data-username', data.Username);
                    }
                })
            }
        }
        function validateUsername(self) {
            var username = $(self).val().trim();
            if (username) {
                User.formAction = '/MasterMaintenance/UserMaster/ValidateUsername';
                User.jsonData = { Username: username }
                User.sendData().then(function () {
                    var validUsername = User.responseData.isValid;
                    if (!validUsername) {
                        User.showError("Username already exists. Please try another Username");
                        $(self).val("");
                        $(self).focus();
                    } else {
                        $("#Email").focus();
                    }
                });
            }
        }
        function validateEmail(self) {
            var email = $(self).val().trim();
            if (email) {
                User.formAction = '/MasterMaintenance/UserMaster/ValidateEmail';
                User.jsonData = { Email: email }
                User.sendData().then(function () {
                    var validEmail = User.responseData.isValid;
                    if (!validEmail) {
                        User.showError("Email already exists. Please try another Email");
                        $(self).val("");
                        $(self).focus();
                    } else {
                        $("#FirstName").focus();
                    }
                });
            }
        }
        function generatePassword() {
            var length = 8,
                charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
                retVal = "";
            for (var i = 0, n = charset.length; i < length; ++i) {
                retVal += charset.charAt(Math.floor(Math.random() * n));
            }
            return retVal;
        }
        function saveUser() {
            User.formData = $('#frmUser').serializeArray();
            User.formAction = '/MasterMaintenance/UserMaster/SaveUser';
            User.setJsonData().sendData().then(function () {
                tblUser.ajax.reload(null, false);
                cancelUserTbl();
                cancelUserForm();
            });
        }
        function cancelUserForm() {
            User.clearFromData("frmUser");
            $('#Username').prop('readonly', false);
            $("#mdlUserTitle").text(" Create User");
            $("#btnSaveUser .btnLabel").text(" Save");
            $("#Role option[value='Custom']").remove();
            $("#mdlUser").modal("hide");
        }
        function cancelUserTbl() {
            $('#btnEditUser').attr("disabled", "disabled");
            $('#btnDeleteUser').attr("disabled", "disabled");
            $('#btnUserAccess').attr("disabled", "disabled");
        }
        function dis_se_lectUserRow(UserRow) {
            if (UserRow.data("username")) {
                if (UserRow.hasClass('selected')) {
                    UserRow.removeClass('selected');
                    Username = "";
                    ID = 0;
                    $('#btnEditUser').attr("disabled", "disabled");
                    $('#btnDeleteUser').attr("disabled", "disabled");
                    $('#btnUserAccess').attr("disabled", "disabled");
                }
                else {
                    tblUser.$('tr.selected').removeClass('selected');
                    UserRow.addClass('selected');
                    Username = UserRow.data("username");
                    ID = UserRow.data("id");
                    $('#btnEditUser').removeAttr("disabled");
                    $('#btnDeleteUser').removeAttr("disabled");
                    $('#btnUserAccess').removeAttr("disabled");
                }
            }
        }
        function editUser() {
            User.formAction = '/MasterMaintenance/UserMaster/GetUserDetails';
            if (User.formAction) {
                User.jsonData = { Username: Username };
                User.sendData().then(function () {
                    populateUserData(User.responseData.userData);
                });
            } else {
                User.showError("Please try again.");
            }
        }
        function populateUserData(user) {
            $('#Username').prop('readonly', true);
            $("#frmUser").parsley().reset();
            $("#mdlUserTitle").text(" Update User");
            $("#btnSaveUser .btnLabel").text(" Update");
            if (user.Role == "Custom")
                $("#Role").append("<option value='Custom'>Custom</option>");
            else
                $("#Role option[value='Custom']").remove();
            User.populateToFormInputs(user, "#frmUser");
            var userOption = new Option(user.DepartmentDesc, user.Department, true, true);
            $('#Department').append(userOption).trigger('change');
            $("#mdlUser").modal("show");
        }
        function deleteUser() {
            User.formAction = '/MasterMaintenance/UserMaster/DeleteUser';
            User.jsonData = { Username: Username };
            User.sendData().then(function () {
                tblUser.ajax.reload(null, false);
                cancelUserTbl();
                cancelUserForm();
            });
        }
        function getUserAccess() {
            User.formAction = '/MasterMaintenance/UserMaster/GetUserAccess';
            User.jsonData = { ID: ID };
            User.sendData().then(function () {
                drawUserMenu(User.responseData);
            });
        }
        function drawUserMenu(menu) {
            const tmpForParentMenu = menu;
            const tmpForSubMenu = menu;
            //Grouping menus into GroupLabel
            var arrGroupedData = _.mapValues(_.groupBy(menu, 'GroupLabel'), (function (clist) {
                return clist.map(function (byGroupLabel) {
                    return _.omit(byGroupLabel, 'GroupLabel');
                });
            }));
            //End Grouping menus into GroupLabel 
            //Creating GroupLabel Tab Link
            var menuTab = "<ul class='nav nav-tabs'>";
            $.each(arrGroupedData, function (i) {
                var GroupLabelID = i == "" ? "Common" : i;
                var active = i == "" ? "active" : "";
                menuTab += "<li class='nav-items'>\
                                    <a href='#tab" + GroupLabelID + "' data-toggle='tab' class='nav-link " + active + "'>\
                                        <span class='d-sm-none'>" + GroupLabelID + "</span>\
                                        <span class='d-sm-block d-none'> " + GroupLabelID + "</span>\
                                    </a>\
                                 </li>";
            });
            menuTab += "</ul>";
            //End Creating GroupLabel Tab Link

            //Creating GroupLabel Tab Content
            menuTab += "<div class='tab-content'>";
            $.each(arrGroupedData, function (i, groupedMainMenu) {
                var GroupLabelID = i == "" ? "Common" : i;
                var active = i == "" ? "active" : "";
                //Creating GroupLabel Individual Tab Content
                menuTab += "<div class='tab-pane show " + active + "' id='tab" + GroupLabelID + "'>";
                //Creating Parent Menu Tab Link
                menuTab += "    <ul class='nav nav-tabs'>";
                var parentMenu = _.filter(groupedMainMenu, function (obj) { return obj.Icon != 0; });
                var sortedParentMenu = _.sortBy(parentMenu, function (o) { return new Number(o.ParentOrder); }, ['asc']);
                $.each(sortedParentMenu, function (ii) {
                    var active1 = (ii == 0 && GroupLabelID == "Common") || (ii == 0 && GroupLabelID != "Common") ? 'active' : '';
                    if (this.URL != "/") {
                        menuTab += "<li class='nav-items'>\
                                    <a href='#tab" + (this.PageName).replace(/\s/g, "") + "' data-toggle='tab' class='nav-link " + active1 + "'>\
                                        <span class='d-sm-none'><span class='" + this.Icon + "'></span> " + this.PageLabel + "</span>\
                                        <span class='d-sm-block d-none'><span class='" + this.Icon + "'></span> " + this.PageLabel + "</span>\
                                    </a>\
                                 </li>";
                    }
                });
                menuTab += "    </ul>";
                //End Creating Parent Menu Tab Link
                //Creating Parent Menu Tab Content
                menuTab += "<div class='tab-content'>";
                $.each(sortedParentMenu, function (iii, m) {
                    if (this.URL != "/") {
                        var PageName = this.PageName;
                        var PageLabel = this.PageLabel;
                        var submenus = _.filter(groupedMainMenu, function (obj) {
                            return obj.ParentMenu == PageName && obj.Icon == 0;
                        });
                        var sortedSubmenu = _.sortBy(submenus, function (o) { return new Number(o.Order); }, ['asc']);

                        //var show = i == 1 ? 'fade active' : '';
                        var show = (iii == 0 && GroupLabelID == "Common") || (iii == 0 && GroupLabelID != "Common") ? 'fade active' : '';
                        var checked = this.Status != '' ? 'checked' : '';

                        var readOnly = this.ReadAndWrite ? '' : 'checked';
                        var readAndWrite = this.ReadAndWrite ? 'checked' : '';
                        var delChecked = this.Delete ? 'checked' : '';
                        //Creating indivdial menu list content
                        menuTab += "<div class='tab-pane show " + show + "' id='tab" + (PageName).replace(/\s/g, '') + "'>";
                        menuTab += "    <ul>";
                        menuTab += "        <li>";
                        menuTab += "            <div class='checkbox checkbox-css checkbox-inline'>\
                                                    <input type='checkbox'  id='chk" + PageName.replace(/\s/g, '') + "' value='" + this.ID + "' " + checked + " data-pagename='" + PageName.replace(/\s/g, '') + "'  data-childclass='" + PageName.replace(/\s/g, '') + "' class='parentMenu chkUserAccess clickable'>\
                                                    <label class='clickable' for='chk" + PageName.replace(/\s/g, '') + "'>" + PageLabel + "</label>\
                                                </div>";
                        if (!this.HasSub) {
                            menuTab += "            <div class='radio radio-css radio-inline m-l-20'>\
                                                        <input class='form-check-input clickable' type='radio' name='rdoReadAndWrite" + PageName.replace(/\s/g, '') + "' id='rdoRead" + PageName.replace(/\s/g, '') + "' value='0' " + readOnly + ">\
                                                        <label class='form-check-label clickable' for='rdoRead" + PageName.replace(/\s/g, '') + "'>Read Only</label>\
                                                    </div>\
                                                    <div class='radio radio-css radio-inline '>\
                                                        <input class='form-check-input clickable' type='radio' name='rdoReadAndWrite" + PageName.replace(/\s/g, '') + "' id='rdoReadWrite" + PageName.replace(/\s/g, '') + "' value='1' " + readAndWrite + ">\
                                                        <label class='form-check-label clickable' for='rdoReadWrite" + PageName.replace(/\s/g, '') + "'>Read & Write</label>\
                                                    </div>";
                            menuTab += "            <div class='checkbox checkbox-css checkbox-inline m-l-20'>\
                                                        <input type='checkbox'  id='chkDel" + PageName.replace(/\s/g, "") + "' value='" + this.ID + "' " + delChecked + " data-pagename='" + PageName.replace(/\s/g, "") + "' class='clickable'>\
                                                        <label class='clickable' for='chkDel" + PageName.replace(/\s/g, "") + "'>Delete</label>\
                                                    </div>";
                        }
                        menuTab += "        </li>";

                        if (sortedSubmenu.length) {
                            if (PageName == sortedSubmenu[0].ParentMenu) {
                                menuTab += "        <li>";
                                menuTab += "            <ul>";
                                $.each(sortedSubmenu, function (index) {
                                    var subChecked = this.Status != '' ? 'checked' : '';
                                    var readOnlySub = this.ReadAndWrite ? '' : 'checked';
                                    var delChecked = this.Delete ? 'checked' : '';
                                    var readAndWriteSub = this.ReadAndWrite ? 'checked' : '';
                                    menuTab += "            <li>";
                                    menuTab += "                <div class='row'>";
                                    menuTab += "                    <div class='col-sm-2'>";
                                    menuTab += "                        <div class='checkbox checkbox-css checkbox-inline'>\
                                                                            <input type='checkbox'  id='chkSub" + this.PageName.replace(/\s/g, "") + "' value='" + this.ID + "' " + subChecked + " data-pagename='" + this.PageName.replace(/\s/g, "") + "' data-parent='chk" + this.ParentMenu.replace(/\s/g, "") + "' data-myclass='" + this.ParentMenu.replace(/\s/g, "") + "' class='subMenu chkUserAccess " + this.ParentMenu.replace(/\s/g, "") + " clickable'>\
                                                                            <label class='clickable' for='chkSub" + this.PageName.replace(/\s/g, "") + "'>" + this.PageName + "</label>\
                                                                        </div>";
                                    menuTab += "                    </div>";
                                    menuTab += "                    <div class='col-sm-2'>";
                                    menuTab += "                        <div class='radio radio-css radio-inline'>\
                                                                            <input class='form-check-input clickable' type='radio' name='rdoReadAndWrite" + this.PageName.replace(/\s/g, '') + "' id='rdoRead" + this.PageName.replace(/\s/g, '') + "' value='0' " + readOnlySub + ">\
                                                                            <label class='form-check-label  clickable' for='rdoRead" + this.PageName.replace(/\s/g, '') + "'>Read Only</label>\
                                                                        </div>\
                                                                    </div>";
                                    menuTab += "                    <div class='col-sm-2'>\
                                                                        <div class='radio radio-css radio-inline'>\
                                                                            <input class='form-check-input clickable' type='radio' name='rdoReadAndWrite" + this.PageName.replace(/\s/g, '') + "' id='rdoReadWrite" + this.PageName.replace(/\s/g, '') + "' value='1' " + readAndWriteSub + ">\
                                                                            <label class='form-check-label  clickable' for='rdoReadWrite" + this.PageName.replace(/\s/g, '') + "'>Read & Write</label>\
                                                                        </div>\
                                                                    </div>";
                                    menuTab += "                    <div class='col-sm-2'>";
                                    menuTab += "                        <div class='checkbox checkbox-css checkbox-inline'>\
                                                                            <input type='checkbox'  id='chkDel" + this.PageName.replace(/\s/g, "") + "' value='" + this.ID + "' " + delChecked + " class='clickable'/>\
                                                                            <label class='clickable' for='chkDel" + this.PageName.replace(/\s/g, "") + "'>Delete</label>\
                                                                        </div>";
                                    menuTab += "                    </div>";
                                    menuTab += "                </div>";
                                    menuTab += "            </li>";
                                });
                                menuTab += "            </ul>";
                                menuTab += "        </li>";
                            }
                        }

                        menuTab += "    </ul>";
                        menuTab += "</div>";
                        //End Creating indivdial menu list content
                    }
                });

                menuTab += "</div>";
                //Creating Parent Menu Tab Content
                menuTab += "</div>";
                //End Creating GroupLabel Individual Tab Content
            });
            menuTab += "</div>";
            //End Creating GroupLabel Tab Content
            $("#mdlBodyUserAccess").html(menuTab);
            $("#mdlUserAccess").modal("show");
            return;
            //==============================================================================================================================================================
        }
        function saveUserAccess() {
            var arrAccessList = [];
            $(".chkUserAccess").each(function (i, val) {
                var userAccessList = {};
                var status = "";
                var pagename = $(this).data("pagename");
                var readAndWrite = "0";
                var deleteFunction = "0";
                if ($(this).is(":checked")) {
                    status = true;
                } else {
                    status = false;
                }
                if ($("input[name=rdoReadAndWrite" + pagename + "]").length) {
                    readAndWrite = $("input[name=rdoReadAndWrite" + pagename + "]:checked").val();
                }
                if ($("#chkDel" + pagename).is(":checked")) {
                    deleteFunction = "1"
                }
                userAccessList = {
                    UserID: ID,
                    PageID: $(this).val(),
                    Status: status,
                    ReadAndWrite: readAndWrite,
                    Delete: deleteFunction
                }
                arrAccessList.push(userAccessList);
            })
            User.formAction = '/MasterMaintenance/UserMaster/SaveUserAccess';
            User.jsonData = { userAccessList: arrAccessList };
            User.sendData().then(function (response) {
                tblUser.ajax.reload(null, false);
                cancelUserTbl();
            });
        }
    });
})();
