"use strict";
(function () {
    var Item = $D();
    var tblItemMaster = "";
    var Username = "";
    var ID = 0;

    $(document).ready(function () {
        drawDatatables();
        $("#btnAddItemMaster").click(function () {
            $("#mdlItemMaster").modal("show");
        });
        $('#btnCancelItem').click(function () {
            cancelItemMasterForm();
            CUI.setDatatableMaxHeight();
        });
        $("#frmItemMaster").submit(function (e) {
            e.preventDefault();
            saveItemMaster();
        });
        $('#tblItemMaster tbody').on('click', 'tr', function () {
            dis_se_lectUserRow($(this));
        });
        $('#btnEditItemMaster').click(function () {
            editItemMaster();
        });
        $('#btnDeleteItemMaster').click(function () {
            Item.msg = "Are you sure you want to delete this Item?";
            Item.confirmAction().then(function (approve) {
                if (approve)
                    deleteItem();
            });
        });
        $('#btnExcelUpload').click(function () {
            alert('upload');
            //getUserAccess();
        });
        //#Special Events
        tblItemMaster.on('draw.dt', function () {
            CUI.dataTableID = "#tblItemMaster";
            CUI.setDatatableMaxHeight();
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        $('#mdlItemMaster').on('shown.bs.modal', function (e) {
            $('#Model').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'ID',
                            text: 'Value',
                            table: 'mGeneral',
                            db: 'Fujifilm_WMS',
                            condition: ' AND TypeID=2 ',
                            display: 'id&text',
                        };
                    },
                },
                placeholder: '--Please Select--',
            });
            $('#Category').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'ID',
                            text: 'Value',
                            table: 'mGeneral',
                            db: 'Fujifilm_WMS',
                            condition: ' AND TypeID=3 ',
                            display: 'id&text',
                        };
                    },
                },
                placeholder: '--Please Select--',
            });
            $('#UOM').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'ID',
                            text: 'Value',
                            table: 'mGeneral',
                            db: 'Fujifilm_WMS',
                            condition: ' AND TypeID=4 ',
                            display: 'id&text',
                        };
                    },
                },
                placeholder: '--Please Select--',
            });
        });
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            if (!$.fn.DataTable.isDataTable('#tblItemMaster')) {
                tblItemMaster = $('#tblItemMaster').DataTable({
                    processing: true,
                    serverSide: true,
                    "order": [[0, "asc"]],
                    "pageLength": 25,
                    "ajax": {
                        "url": "/MasterMaintenance/ItemMaster/GetItemList",
                        "type": "POST",
                        "datatype": "json",
                    },
                    responsive: true,
                    dataSrc: "data",
                    columns: [
                        { title: "Part Number", data: 'PartNumber' },
                        
                        { title: "Part Name", data: 'PartName' },
                        { title: "Unit", data: 'UOM' },
                        { title: "Model", data: 'Model' },
                        { title: "Category", data: 'Category' },
                        {
                            title: "Status", data: 'Status', render: function (data) {
                                return data == 0 ? 'Active' : 'Inactive';
                            }
                        }
                    ],
                    "createdRow": function (row, data, dataIndex) {
                        $(row).attr('data-id', data.ID);
                    }
                })
            }
        }
        function saveItemMaster() {
            Item.formData = $('#frmItemMaster').serializeArray();
            Item.formAction = '/MasterMaintenance/ItemMaster/SaveItem';
            Item.setJsonData().sendData().then(function () {
                tblItemMaster.ajax.reload(null, false);
                cancelItemMasterTbl();
                cancelItemMasterForm();
            });
        }
        function cancelItemMasterForm() {
            Item.clearFromData("frmItemMaster");
            //$('#Username').prop('readonly', false);
            //$("#mdlUserTitle").text(" Create User");
            //$("#btnSaveUser .btnLabel").text(" Save");
            //$("#Role option[value='Custom']").remove();
            $("#mdlItemMaster").modal("hide");
        }
        function cancelItemMasterTbl() {
            $('#btnEditItemMaster').attr("disabled", "disabled");
            $('#btnDeleteItemMaster').attr("disabled", "disabled");
        }
        function dis_se_lectUserRow(ItemRow) {
            if (ItemRow.data("id")) {
                if (ItemRow.hasClass('selected')) {
                    ItemRow.removeClass('selected');
                    //Username = "";
                    ID = 0;
                    $('#btnEditItemMaster').attr("disabled", "disabled");
                    $('#btnDeleteItemMaster').attr("disabled", "disabled");
                }
                else {
                    tblItemMaster.$('tr.selected').removeClass('selected');
                    ItemRow.addClass('selected');
                    //Username = ItemRow.data("username");
                    ID = ItemRow.data("id");
                    $('#btnEditItemMaster').removeAttr("disabled");
                    $('#btnDeleteItemMaster').removeAttr("disabled");
                }
            }
            else {
                alert('else');
            }
        }
        function editItemMaster() {
            Item.formAction = '/MasterMaintenance/ItemMaster/GetItemDetails';
            if (Item.formAction) {
                Item.jsonData = { ID: ID };
                Item.sendData().then(function () {
                    populateItemData(Item.responseData.itemData);
                });
            } else {
                Item.showError("Please try again.");
            }
        }
        function populateItemData(item) {
            $('#PartNumber').prop('readonly', true);
            $("#frmItemMaster").parsley().reset();
            $("#mdlItemMasterTitle").text(" Update Part Number");
            $("#btnSaveItem .btnLabel").text(" Update");
            Item.populateToFormInputs(item, "#frmItemMaster");
            var modelOption = new Option(item.ModelValue, item.Model, true, true);
            var categoryOption = new Option(item.CategoryValue, item.Category, true, true);
            var UOMOption = new Option(item.UOMValue, item.UOM, true, true);
            $('#Model').append(modelOption).trigger('change');
            $('#Category').append(categoryOption).trigger('change');
            $('#UOM').append(UOMOption).trigger('change');
            $("#mdlItemMaster").modal("show");
        }
        function deleteItem() {
            Item.formAction = '/MasterMaintenance/ItemMaster/DeleteItem';
            Item.jsonData = { ID: ID };
            Item.sendData().then(function () {
                tblItemMaster.ajax.reload(null, false);
                cancelItemMasterTbl();
                cancelItemMasterForm();
            });
        }
    });
})();
