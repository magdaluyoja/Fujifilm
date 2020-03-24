"use strict";
(function () {
    var Supplier = $D();
    var tblSupplierMaster = "";
    var Username = "";
    var ID = 0;

    $(document).ready(function () {
        drawDatatables();
        $("#btnAddSupplierMaster").click(function () {
            $("#mdlSupplierMaster").modal("show");
        });
        $('#btnCancelSupplier').click(function () {
            cancelSupplierMasterForm();
            CUI.setDatatableMaxHeight();
        });
        $("#frmSupplierMaster").submit(function (e) {
            e.preventDefault();
            saveSupplierMaster();
        });
        $('#tblSupplierMaster tbody').on('click', 'tr', function () {
            dis_se_lectUserRow($(this));
        });
        $('#btnEditSupplierMaster').click(function () {
            editSupplierMaster();
        });
        $('#btnDeleteSupplierMaster').click(function () {
            Supplier.msg = "Are you sure you want to delete this Supplier?";
            Supplier.confirmAction().then(function (approve) {
                if (approve)
                    deleteSupplier();
            });
        });
        //#Special Events
        tblSupplierMaster.on('draw.dt', function () {
            CUI.dataTableID = "#tblItemMaster";
            CUI.setDatatableMaxHeight();
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        //$('#mdlSupplierMaster').on('shown.bs.modal', function (e) {
        //    $('#Model').select2({
        //        ajax: {
        //            url: "/General/GetSelect2Data",
        //            data: function (params) {
        //                return {
        //                    q: params.term,
        //                    id: 'ID',
        //                    text: 'Value',
        //                    table: 'mGeneral',
        //                    db: 'Fujifilm_WMS',
        //                    condition: ' AND TypeID=2 ',
        //                    display: 'id&text',
        //                };
        //            },
        //        },
        //        placeholder: '--Please Select--',
        //    });
        //    $('#Category').select2({
        //        ajax: {
        //            url: "/General/GetSelect2Data",
        //            data: function (params) {
        //                return {
        //                    q: params.term,
        //                    id: 'ID',
        //                    text: 'Value',
        //                    table: 'mGeneral',
        //                    db: 'Fujifilm_WMS',
        //                    condition: ' AND TypeID=3 ',
        //                    display: 'id&text',
        //                };
        //            },
        //        },
        //        placeholder: '--Please Select--',
        //    });
        //    $('#UOM').select2({
        //        ajax: {
        //            url: "/General/GetSelect2Data",
        //            data: function (params) {
        //                return {
        //                    q: params.term,
        //                    id: 'ID',
        //                    text: 'Value',
        //                    table: 'mGeneral',
        //                    db: 'Fujifilm_WMS',
        //                    condition: ' AND TypeID=4 ',
        //                    display: 'id&text',
        //                };
        //            },
        //        },
        //        placeholder: '--Please Select--',
        //    });
        //});
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            if (!$.fn.DataTable.isDataTable('#tblSupplierMaster')) {
                tblSupplierMaster = $('#tblSupplierMaster').DataTable({
                    processing: true,
                    serverSide: true,
                    "order": [[0, "asc"]],
                    "pageLength": 25,
                    "ajax": {
                        "url": "/MasterMaintenance/SupplierMaster/GetSupplierList",
                        "type": "POST",
                        "datatype": "json"
                    },
                    responsive: true,
                    dataSrc: "data",
                    columns: [
                        { title: "Supplier Code", data: 'SupplierCode' },

                        { title: "Supplier Name", data: 'SupplierName' },
                        { title: "Supplier Abbrev", data: 'SupplierAbbrev' },
                        {
                            title: "Status", data: 'Status', render: function (data) {
                                return data == 0 ? 'Active' : 'Inactive';
                            }
                        }
                    ],
                    "createdRow": function (row, data, dataIndex) {
                        $(row).attr('data-id', data.ID);
                    }
                });
            }
        }
        function saveSupplierMaster() {
            Supplier.formData = $('#frmSupplierMaster').serializeArray();
            Supplier.formAction = '/MasterMaintenance/SupplierMaster/SaveSupplier';
            Supplier.setJsonData().sendData().then(function () {
                tblSupplierMaster.ajax.reload(null, false);
                cancelSupplierMasterTbl();
                cancelSupplierMasterForm();
            });
        }
        function cancelSupplierMasterForm() {
            Supplier.clearFromData("frmSupplierMaster");
            //$('#Username').prop('readonly', false);
            //$("#mdlUserTitle").text(" Create User");
            //$("#btnSaveUser .btnLabel").text(" Save");
            //$("#Role option[value='Custom']").remove();
            $("#mdlSupplierMaster").modal("hide");
        }
        function cancelSupplierMasterTbl() {
            $('#btnEditSupplierMaster').attr("disabled", "disabled");
            $('#btnDeleteSupplierMaster').attr("disabled", "disabled");
        }
        function dis_se_lectUserRow(SupplierRow) {
            if (SupplierRow.data("id")) {
                if (SupplierRow.hasClass('selected')) {
                    SupplierRow.removeClass('selected');
                    //Username = "";
                    ID = 0;
                    $('#btnEditSupplierMaster').attr("disabled", "disabled");
                    $('#btnDeleteSupplierMaster').attr("disabled", "disabled");
                }
                else {
                    tblSupplierMaster.$('tr.selected').removeClass('selected');
                    SupplierRow.addClass('selected');
                    //Username = ItemRow.data("username");
                    ID = SupplierRow.data("id");
                    $('#btnEditSupplierMaster').removeAttr("disabled");
                    $('#btnDeleteSupplierMaster').removeAttr("disabled");
                }
            }
            else {
                alert('else');
            }
        }
        function editSupplierMaster() {
            Supplier.formAction = '/MasterMaintenance/SupplierMaster/GetSupplierDetails';
            if (Supplier.formAction) {
                Supplier.jsonData = { ID: ID };
                Supplier.sendData().then(function () {
                    populateSupplierData(Supplier.responseData.supplierData);
                });
            } else {
                Supplier.showError("Please try again.");
            }
        }
        function populateSupplierData(supplier) {
            $('#SupplierCode').prop('readonly', true);
            $("#frmSupplierMaster").parsley().reset();
            $("#mdlSupplierMasterTitle").text(" Update Part Number");
            $("#btnSaveSupplier .btnLabel").text(" Update");

            console.log(supplier);
            console.table(supplier);
            Supplier.populateToFormInputs(supplier, "#frmSupplierMaster");
            $("#mdlSupplierMaster").modal("show");
        }
        function deleteSupplier() {
            Supplier.formAction = '/MasterMaintenance/SupplierMaster/DeleteSupplier';
            Supplier.jsonData = { ID: ID };
            Supplier.sendData().then(function () {
                tblSupplierMaster.ajax.reload(null, false);
                cancelSupplierMasterTbl();
                cancelSupplierMasterForm();
            });
        }
    });
})();
