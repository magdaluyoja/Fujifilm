"use strict";
(function () {
    var CostCenter = $D();
    var tblCostCenterMaster = "";
    var Username = "";
    var ID = 0;

    $(document).ready(function () {
        drawDatatables();
        $("#btnAddCostCenterMaster").click(function () {
            $("#mdlCostCenterMaster").modal("show");
        });
        $('#btnCancelCostCenter').click(function () {
            cancelCostCenterMasterForm();
            CUI.setDatatableMaxHeight();
        });
        $("#frmCostCenterMaster").submit(function (e) {
            e.preventDefault();
            saveCostCenterMaster();
        });
        $('#tblCostCenterMaster tbody').on('click', 'tr', function () {
            dis_se_lectUserRow($(this));
        });
        $('#btnEditCostCenterMaster').click(function () {
            editCostCenterMaster();
        });
        $('#btnDeleteCostCenterMaster').click(function () {
            CostCenter.msg = "Are you sure you want to delete this Cost Center?";
            CostCenter.confirmAction().then(function (approve) {
                if (approve)
                    deleteCostCenter();
            });
        });
        //#Special Events
        tblCostCenterMaster.on('draw.dt', function () {
            CUI.dataTableID = "#tblCostCenterMaster";
            CUI.setDatatableMaxHeight();
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        $('#mdlCostCenterMaster').on('shown.bs.modal', function (e) {
            $('#DepartmentID').select2({
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
                placeholder: '--Please Select--'
            });
        });
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            if (!$.fn.DataTable.isDataTable('#tblCostCenterMaster')) {
                tblCostCenterMaster = $('#tblCostCenterMaster').DataTable({
                    processing: true,
                    serverSide: true,
                    "order": [[0, "asc"]],
                    "pageLength": 25,
                    "ajax": {
                        "url": "/MasterMaintenance/CostCenter/GetCostCenterList",
                        "type": "POST",
                        "datatype": "json"
                    },
                    responsive: true,
                    dataSrc: "data",
                    columns: [
                        { title: "Department", data: 'DepartmentName' },

                        { title: "Cost Center Code", data: 'CostCenterCode' },
                        { title: "Cost Center Name", data: 'CostCenterName' },
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
        function saveCostCenterMaster() {
            CostCenter.formData = $('#frmCostCenterMaster').serializeArray();
            CostCenter.formAction = '/MasterMaintenance/CostCenter/SaveCostCenter';
            CostCenter.setJsonData().sendData().then(function () {
                tblCostCenterMaster.ajax.reload(null, false);
                cancelCostCenterMasterTbl();
                cancelCostCenterMasterForm();
            });
        }
        function cancelCostCenterMasterForm() {
            CostCenter.clearFromData("frmCostCenterMaster");
            //$('#Username').prop('readonly', false);
            //$("#mdlUserTitle").text(" Create User");
            //$("#btnSaveUser .btnLabel").text(" Save");
            //$("#Role option[value='Custom']").remove();
            $("#mdlCostCenterMaster").modal("hide");
        }
        function cancelCostCenterMasterTbl() {
            $('#btnEditCostCenterMaster').attr("disabled", "disabled");
            $('#btnDeleteCostCenterMaster').attr("disabled", "disabled");
        }
        function dis_se_lectUserRow(CostCenterRow) {
            if (CostCenterRow.data("id")) {
                if (CostCenterRow.hasClass('selected')) {
                    CostCenterRow.removeClass('selected');
                    //Username = "";
                    ID = 0;
                    $('#btnEditCostCenterMaster').attr("disabled", "disabled");
                    $('#btnDeleteCostCenterMaster').attr("disabled", "disabled");
                }
                else {
                    tblCostCenterMaster.$('tr.selected').removeClass('selected');
                    CostCenterRow.addClass('selected');
                    //Username = ItemRow.data("username");
                    ID = CostCenterRow.data("id");
                    $('#btnEditCostCenterMaster').removeAttr("disabled");
                    $('#btnDeleteCostCenterMaster').removeAttr("disabled");
                }
            }
            else {
                alert('else');
            }
        }
        function editCostCenterMaster() {
            CostCenter.formAction = '/MasterMaintenance/CostCenter/GetCostCenterDetails';
            if (CostCenter.formAction) {
                CostCenter.jsonData = { ID: ID };
                CostCenter.sendData().then(function () {
                    populateCostCenterData(CostCenter.responseData.costCenterData);
                });
            } else {
                CostCenter.showError("Please try again.");
            }
        }
        function populateCostCenterData(costCenter) {
            $('#CostCenterCode').prop('readonly', true);
            $("#frmCostCenterMaster").parsley().reset();
            $("#mdlCostCenterMasterTitle").text(" Update Cost Center");
            $("#btnSaveCostCenter .btnLabel").text(" Update");

            CostCenter.populateToFormInputs(costCenter, "#frmCostCenterMaster");
            var departmentOption = new Option(costCenter.DepartmentName, costCenter.DepartmentID, true, true);
            $('#DepartmentID').append(departmentOption).trigger('change');
            $("#mdlCostCenterMaster").modal("show");
        }
        function deleteCostCenter() {
            CostCenter.formAction = '/MasterMaintenance/CostCenter/DeleteCostCenter';
            CostCenter.jsonData = { ID: ID };
            CostCenter.sendData().then(function () {
                tblCostCenterMaster.ajax.reload(null, false);
                cancelCostCenterMasterTbl();
                cancelCostCenterMasterForm();
            });
        }
    });
})();
