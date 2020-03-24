"use strict";
(function () {
    var PurchaseUpload = $D();
    var tblPurchaseUpload = "";
    var ID = 0;

    $(document).ready(function () {
        drawDatatables();

        $("#btnAddPurchaseOrderMaster").click(function () {
            $("#mdlPurchaseOrder").modal("show");
        });
        $('#btnCancelItem').click(function () {
            cancelPurchaseOrderForm();
            CUI.setDatatableMaxHeight();
        });
        $('#btnCancelPurchaseOrder').click(function () {
            cancelPurchaseOrderForm();
        });
        $("#frmPurchaseOrder").submit(function (e) {
            e.preventDefault();
            savePurhcaseOrder();
        });
        $('#btnEditPurchaseOrderMaster').click(function () {
            editPurchaseOrderMaster();
        });
        $('#btnDeletePurchaseOrderMaster').click(function () {
            PurchaseUpload.msg = "Are you sure you want to delete this PO?";
            PurchaseUpload.confirmAction().then(function (approve) {
                if (approve)
                    deletePurchaseOrder();
            });
        });
        $("#btnUploadPurchaseOrderMaster").click(function () {
            $("#mdlPurchaseOrderUpload").modal("show");
        });
        $("#btnUploadFile").click(function () {
            uploadFile();
        });
        $('#FileUpload').change(function () {
            if ($('#FileUpload')[0].files.length) {
                var files = $('#FileUpload')[0].files;
                var fileNames = [];
                var err = false;
                var arrErr = [];
                for (var i = 0; i <= files.length - 1; i++) {
                    var fname = files.item(i).name;
                    var fsize = files.item(i).size;
                    if (fsize / 1000000 > 50) {
                        arrErr.push("File size is above 50MB. Filename: " + fname);
                        err = true;
                    } else {
                        fileNames.push(fname);
                    }
                }
                if (err) {
                    PurchaseUpload.msgType = "error";
                    PurchaseUpload.msgTitle = "Error!";
                    PurchaseUpload.msg = arrErr;
                    PurchaseUpload.showToastrMsg();
                } else {
                    $("#lblNewPurchaseUpload").val(fileNames.join(", "));
                    $("#lblNewPurchaseUpload").prop("readonly", true);
                }

            } else {
                $("#lblNewPurchaseUpload").val("");
                $("#lblNewPurchaseUpload").prop("readonly", false);
            }
        });
        //#OnChange
        $('#Department').change(function () {
            $('#Cost_Center').val(null).trigger('change.select2');
        });
        $('#PO_No').change(function () {
            console.log($("#PO_No").val());
            if ($(this).val())
                getPOLnNO();
            else
                $("#PO_Ln_No").val("");
        });
        $('#Material').change(function () {
            if ($(this).val())
                getUOM();
            else
                $("#Unit").val("");
        });
        //#Special Events
        tblPurchaseUpload.on('select', function (e, dt, type, indexes) {
            $(".tbl-tr-btns").prop("disabled", false);
        });
        tblPurchaseUpload.on('deselect', function (e, dt, type, indexes) {
            $(".tbl-tr-btns").prop("disabled", true);
        });

        tblPurchaseUpload.on('draw.dt', function () {
            CUI.dataTableID = "#tblPurchaseUpload";
            CUI.setDatatableMaxHeight();
            cancelPurhaseOrderTbl();
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        $('#mdlPurchaseOrder').on('shown.bs.modal', function (e) {
            $("#PO_Issued_Date, #Requested_Delivery_Date").datepicker({
                autoclose: true,
                todayHighlight: true
            });
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
                allowClear: true,
                placeholder: '--Please Select--',
            });
            $('#Cost_Center').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        var DeptID = $("#Department").val() ? $("#Department").val() : "";
                        return {
                            q: params.term,
                            id: 'CostCenterCode',
                            text: 'CostCenterName',
                            table: 'mCostCenter',
                            db: 'Fujifilm_WMS',
                            condition: " AND DepartmentID= '" + DeptID + "'",
                            display: 'id&text',
                        };
                    },
                },
                allowClear: true,
                placeholder: '--Please Select--',
            });
            $('#Vendor').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'ID',
                            text: 'SupplierCodeName',
                            table: 'mSupplier',
                            db: 'Fujifilm_WMS',
                            //condition: ' AND TypeID=1 ',
                            query: "select ID,CONCAT(SupplierCode,' - ',SupplierName) as SupplierCodeName from mSupplier where IsDeleted=0",
                            display: 'id&text'
                        };
                    }
                },
                allowClear: true,
                placeholder: '--Please Select--',
            });
            $('#PO_No').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'PO_No',
                            text: 'PO_No',
                            table: 'pPurchaseOrderUpload',
                            db: 'Fujifilm_WMS',
                            //condition: ' AND TypeID=1 ',
                            //query: "select ID,CONCAT(SupplierCode,' - ',SupplierName) as SupplierCodeName from mSupplier where IsDeleted=0",
                            display: 'id&text',
                            isDistict: true
                        };
                    }
                },
                allowClear: true,
                placeholder: '--Please Select--',
                tags: true
            });
            $('#Material').select2({
                ajax: {
                    url: "/General/GetSelect2Data",
                    data: function (params) {
                        return {
                            q: params.term,
                            id: 'ID',
                            text: 'PartCodeName',
                            table: 'mItemMaster',
                            db: 'Fujifilm_WMS',
                            //condition: ' AND TypeID=1 ',
                            query: "select ID,CONCAT(PartNumber,' - ',PartName) as PartCodeName from mItemMaster where IsDeleted=0",
                            display: 'id&text'
                        };
                    }
                },
                allowClear: true,
                placeholder: '--Please Select--',
            });
        });
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            tblPurchaseUpload = $('#tblPurchaseUpload').DataTable({
                processing: true,
                serverSide: true,
                "pageLength": 25,
                "ajax": {
                    "url": "/Input/PurchaseUpload/GetPurchaseList",
                    "type": "POST",
                    "datatype": "json",
                },
                //responsive: true,
                dataSrc: "data",
                select: true,
                columns: [
                    { title: "Department", data: "Department", className: "" },
                    { title: "Cost Center", data: "Cost_Center", className: "" },
                    { title: "Vendor Code", data: "Vendor", className: "" },
                    { title: "Vendor Name", data: "Vendor_Name", className: "" },
                    {
                        title: "PO Date", data: "PO_Issued_Date", className: "",
                        render: function (data) {
                            return $F(data).formatDate("mm/dd/yyyy");
                        }
                    },
                    { title: "PO No", data: "PO_No", className: "" },
                    { title: "PO Ln No", data: "PO_Ln_No", className: "" },
                    { title: "Material", data: "Material", className: "" },
                    { title: "Material Description", data: "Material_Description", className: "" },
                    { title: "Unit", data: "Unit", className: "" },
                    {
                        title: "Req Del Date", data: "Requested_Delivery_Date", className: "",
                        render: function (data) {
                            return $F(data).formatDate("mm/dd/yyyy");
                        }
                    },
                    { title: "PO Bal", data: "PO_Balance", className: "" },
                    { title: "Deleted", data: "IsDeleted" },
                ],
                "createdRow": function (row, data, dataIndex) {
                    if (data.IsDeleted === "True") {
                        $(row).addClass('errorRow');
                    }
                }
            });
        }
        function uploadFile() {
            var uploadFile = new FormData();
            var file = $("#FileUpload").get(0).files;
            uploadFile.append("PurchaseUpload", file[0]);
            PurchaseUpload.formAction = '/Input/PurchaseUpload/UploadFile';
            PurchaseUpload.jsonData = uploadFile;
            PurchaseUpload.sendFile().then(function () {
                $("#FileUpload").val("");
                $("#lblNewPurchaseUpload").val("");
                tblPurchaseUpload.ajax.reload(null, false);
            });
        }
        function savePurhcaseOrder() {
            PurchaseUpload.formData = $('#frmPurchaseOrder').serializeArray();
            PurchaseUpload.formAction = '/Input/PurchaseUpload/SavePurchaseOrder';
            PurchaseUpload.setJsonData().sendData().then(function () {
                tblPurchaseUpload.ajax.reload(null, false);
                cancelPurhaseOrderTbl();
                cancelPurchaseOrderForm();
            });
        }
        function cancelPurchaseOrderForm() {
            PurchaseUpload.clearFromData("frmPurchaseOrder");
            setReadOnly();
            $("#mdlPurchaseOrderTitle").text(" Create New PO");
            $("#btnSavePurchaseOrder .btnLabel").text(" Save");
            $("#mdlPurchaseOrderTitle").modal("hide");
        }
        function cancelPurhaseOrderTbl() {
            $('#btnEditPurchaseOrderMaster').attr("disabled", "disabled");
            $('#btnDeletePurchaseOrderMaster').attr("disabled", "disabled");
        }
        function editPurchaseOrderMaster() {
            var ID = tblPurchaseUpload.rows({ selected: true }).data()[0].ID;
            PurchaseUpload.formAction = '/Input/PurchaseUpload/GetPurchaseUploadDetails';
            PurchaseUpload.jsonData = { ID: ID };
            PurchaseUpload.sendData().then(function () {
                populatePurchaseOrderData(PurchaseUpload.responseData);
            });
        }
        function setReadOnly() {
            $('#PO_Ln_No').prop('readonly', true);
            $('#Unit').prop('readonly', true);
        }
        function populatePurchaseOrderData(PurchaseUploadDetails) {
            setReadOnly();
            $("#frmPurchaseOrder").parsley().reset();
            $("#mdlPurchaseOrderTitle").text(" Update PO");
            $("#btnSavePurchaseOrder .btnLabel").text(" Update");
            PurchaseUpload.populateToFormInputs(PurchaseUploadDetails, "#frmPurchaseOrder");
            var DepartmentOption = new Option(PurchaseUploadDetails.Department_Desc, PurchaseUploadDetails.Department, true, true);
            var CostCenterOption = new Option(PurchaseUploadDetails.Cost_Center_Desc, PurchaseUploadDetails.Cost_Center, true, true);
            var VendorOption = new Option(PurchaseUploadDetails.Vendor + "-" + PurchaseUploadDetails.Vendor_Name, PurchaseUploadDetails.VendorID, true, true);
            var MaterialOption = new Option(PurchaseUploadDetails.Material_Description, PurchaseUploadDetails.Material, true, true);
            var PO_NoOption = new Option(PurchaseUploadDetails.PO_No, PurchaseUploadDetails.PO_No, true, true);
            $('#Department').append(DepartmentOption).trigger('change.select2');
            $('#Cost_Center').append(CostCenterOption).trigger('change.select2');
            $('#Vendor').append(VendorOption).trigger('change.select2');
            $('#Material').append(MaterialOption).trigger('change.select2');
            $('#PO_No').append(PO_NoOption).trigger('change.select2');
            $("#mdlPurchaseOrder").modal("show");
        }
        function deletePurchaseOrder() {
            var ID = tblPurchaseUpload.rows({ selected: true }).data()[0].ID;
            PurchaseUpload.formAction = '/Input/PurchaseUpload/DeletePO';
            PurchaseUpload.jsonData = { ID: ID };
            PurchaseUpload.sendData().then(function () {
                tblPurchaseUpload.ajax.reload(null, false);
            });
        }
        function getUOM() {
            PurchaseUpload.formAction = '/Input/PurchaseUpload/GetUOM';
            PurchaseUpload.jsonData = { MaterialID: $("#Material").val() };
            PurchaseUpload.sendData().then(function () {
                var UOM = PurchaseUpload.responseData;
                $("#Unit").val(UOM);
            });
        }
        function getPOLnNO() {
            console.log($("#PO_No").val());
            PurchaseUpload.formAction = '/Input/PurchaseUpload/GetPOLnNo';
            PurchaseUpload.jsonData = { POID: $("#PO_No").val() };
            PurchaseUpload.sendData().then(function () {
                var Number = PurchaseUpload.responseData;
                $("#PO_Ln_No").val(Number);
            });
        }
    });
})();
