"use strict";
(function () {
    var Receiving = $D();
    var tblPurchaseOrderItems = "";
    var tblViewReceivingHistory = "";
    var Username = "";
    var ID = 0;
    var arrPOItems = [];

    $(document).ready(function () {
        drawDatatables();
        //#OnLoad Event
        $('#PONo').select2({
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
                        display: 'id&text',
                        isDistict: true
                    };
                },
            },
            placeholder: '--Please Select--'
        });
        $('#PONo').change(function () {
            console.log($("#PONo").val());
            if ($(this).val())
                getSupplierName();
            else
                $("#PONo").val("");
        });
        $("#btnSearch").click(function () {
            getPOItems();
            $('#btnSave').css("display", "");
        });
        $("#tblPurchaseOrderItems").on("change", ".Actual_Qtys", function () {
            validateActual_Qtys($(this));
        })
        $("#tblPurchaseOrderItems").on("change", ".Received_Dates", function () {
            validateReceived_Date($(this));
        })
        $("#tblPurchaseOrderItems").on("click", ".btnViewHistory", function () {
            viewReceivingHistory($(this));
        })
        $("#btnSave").click(function () {
            validateReceivingData();
        });
        //#Special Events
        tblPurchaseOrderItems.on('draw.dt', function () {
            CUI.dataTableID = "#tblPurchaseOrderItems";
            CUI.setDatatableMaxHeight();
            $(".Received_Dates").datepicker({
                highlightToday: true,
                autoclose: true
            });
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            if (!$.fn.DataTable.isDataTable('#tblPurchaseOrderItems')) {
                tblPurchaseOrderItems = $('#tblPurchaseOrderItems').DataTable({
                    //responsive: true,
                    dataSrc: [],
                    columns: [
                        {
                            title: "PO_Issued_Date", data: "PO_Issued_Date", className: "",
                            render: function (data) {
                                return $F(data).formatDate("mm/dd/yyyy");
                            }, visible: false
                        },
                        { title: "PO_Ln_No", data: 'PO_Ln_No', visible: false },
                        { title: "PO_No", data: 'PO_No', visible: false },
                        { title: "Material", data: 'Material' },
                        { title: "Material_Description", data: 'Material_Description' },
                        { title: "Cost Center", data: 'Cost_Center' },
                        {
                            title: "PO Balance", data: 'PO_Balance', className: "text-right", render: function (data) {
                                return data > 0 ? data : 0;
                            }
                        },
                        { title: "Unit", data: 'Unit' },
                        {
                            title: "Requested_Delivery_Date", data: "Requested_Delivery_Date", className: "",
                            render: function (data) {
                                return $F(data).formatDate("mm/dd/yyyy");
                            }, visible: false
                        },
                        {
                            title: "Actual Quantity", data: "Actual_Qty", className: "text-right",
                            render: function (data, type, row) {
                                if ((+row.PO_Balance) > 0)
                                    return "<input type='text' class='form-control Actual_Qtys text-right' style='width:100%;' autocomplete='off' value='" + $F(data).formatMoney(2) + "'/>";
                                else
                                    return "0.00";
                            }
                        },
                        {
                            title: "Received Date", data: "Received_Date", className: "",
                            render: function (data, type, row) {
                                if ((+row.PO_Balance) > 0)
                                    return "<input type='text' class='form-control Received_Dates' style='width:100%;' autocomplete='off' value='" + data + "'/>";
                                else
                                    return "";
                            }
                        },
                        { title: "Unit", data: 'Unit' },
                        {
                            title: "History", data: "HasHistory", className: "",
                            render: function (data) {
                                if (data == "True")
                                    return '<button type="button" class="btn btn-info btn-block btnViewHistory"><span class="fa fa-calendar"></span></button>';
                                else
                                    return "";
                            }
                        },

                    ],
                    "createdRow": function (row, data, dataIndex) {
                        $(row).attr('data-id', data.ID);
                    }
                });
            }
            if (!$.fn.DataTable.isDataTable('#tblViewReceivingHistory')) {
                tblViewReceivingHistory = $('#tblViewReceivingHistory').DataTable({
                    //responsive: true,
                    dataSrc: [],
                    columns: [
                        { title: "PO_Ln_No", data: 'PO_Ln_No' },
                        { title: "PO No", data: 'PONo' },
                        {
                            title: "Actual Quantity", data: "Actual_Qty", className: "text-right"
                        },
                        {
                            title: "Received Date", data: "Received_Date", className: "", render: function (data) {
                                return $F(data).formatDate("mm/dd/yyyy");
                            }
                        },

                    ],
                    "createdRow": function (row, data, dataIndex) {
                        $(row).attr('data-id', data.ID);
                    }
                });
            }
        }
        function getSupplierName() {
            Receiving.formAction = '/ActualReceiving/Receiving/GetSupplierName';
            Receiving.jsonData = { ID: $("#PONo").val() };
            Receiving.sendData().then(function () {
                var SupplierName = Receiving.responseData;
                $("#SupplierName").val(SupplierName);
            });
        }
        function getPOItems() {
            Receiving.formAction = '/ActualReceiving/Receiving/GetOrderReceivingList';
            Receiving.jsonData = { PONo: $("#PONo").val() };
            Receiving.sendData().then(function () {
                arrPOItems = Receiving.responseData;
                tblPurchaseOrderItems.clear();
                tblPurchaseOrderItems.rows.add(arrPOItems);
                tblPurchaseOrderItems.draw();
            });
        }
        function validateActual_Qtys(rowEl) {
            var trData = tblPurchaseOrderItems.row(rowEl.parents('tr')).data();
            if ((+trData.PO_Balance) >= (+rowEl.val())) {
                redrawTableData(rowEl);
                rowEl.removeClass("input-error");
                rowEl.val($F(+rowEl.val()).formatMoney(2));
            } else {
                rowEl.val("");
                rowEl.addClass("input-error");
                Receiving.showError("Invalid quantity. Quantity must be less than or equal than PO Balance.");
            }
        }
        function validateReceived_Date(rowEl) {
            redrawTableData(rowEl);
        }
        function redrawTableData(rowEl) {
            var row = rowEl.parents('tr');
            var trData = tblPurchaseOrderItems.row(rowEl.parents('tr')).data();
            var Actual_Qty = $(row).find('.Actual_Qtys').val();
            var Received_Date = $(row).find('.Received_Dates').val();
            trData.Actual_Qty = Actual_Qty;
            trData.Received_Date = Received_Date;
            _.remove(arrPOItems, function (o) {
                return o.ID === trData.ID;
            });
            arrPOItems.push(trData);
            console.log(arrPOItems);
            //tblPurchaseOrderItems.clear();
            //tblPurchaseOrderItems.rows.add(arrPOItems);
            //tblPurchaseOrderItems.draw();
        }
        function validateReceivingData() {
            var arrRecRows = [];
            var isValid = true;
            tblPurchaseOrderItems.rows().every(function (index, element) {
                var row = $(this.node());
                var statusElement = row.find('td').eq(6); // Index 6 - the 7th column in the table
                if (row.find('.Actual_Qtys').val() > 0) {
                    row.find('.Actual_Qtys').removeClass("input-error");
                } else {
                    row.find('.Actual_Qtys').addClass("input-error");
                    isValid = false;
                }
                if (row.find('.Received_Dates').val()) {
                    row.find('.Received_Dates').removeClass("input-error");
                } else {
                    row.find('.Received_Dates').addClass("input-error");
                    isValid = false;
                }
                arrRecRows.push({
                    ID: tblPurchaseOrderItems.row(this).data().ID,
                    PONo: $("#PONo").val(),
                    PO_Ln_No: tblPurchaseOrderItems.row(this).data().PO_Ln_No,
                    Actual_Qty: row.find('.Actual_Qtys').val(),
                    Received_Date: row.find('.Received_Dates').val(),
                });
                console.log(arrRecRows);
            });
            if (isValid) {
                savePOItemsReceiving(arrRecRows);
            } else {
                Receiving.showError("Please check error-highlighted fields and enter valid value/s.");
            }
        }
        function savePOItemsReceiving(arrRecRows) {
            Receiving.formAction = '/ActualReceiving/Receiving/SavePOReceiving';
            Receiving.jsonData = { POItemsRec: arrRecRows };
            Receiving.sendData().then(function () {
                tblPurchaseOrderItems.clear().draw();
                $("#PONo,#SupplierName").val("").trigger("change");
            });
        }
        function viewReceivingHistory(rowEl) {
            var trData = tblPurchaseOrderItems.row(rowEl.parents('tr')).data();
            Receiving.formAction = '/ActualReceiving/Receiving/ViewReceivingHistory';
            Receiving.jsonData = { PONo: trData.PO_No, PO_Ln_No: trData.PO_Ln_No };
            Receiving.sendData().then(function () {
                tblViewReceivingHistory.clear();
                tblViewReceivingHistory.rows.add(Receiving.responseData);
                tblViewReceivingHistory.draw();
                $("#mdlViewReceivingHistory").modal("show");
            });
        }
    });
})();
