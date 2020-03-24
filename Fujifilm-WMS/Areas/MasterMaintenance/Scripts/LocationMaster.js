"use strict";
(function () {
    var Location = $D();
    var tblLocationMaster = "";
    var Username = "";
    var ID = 0;

    $(document).ready(function () {
        drawDatatables();
        $("#btnAddLocationMaster").click(function () {
            $("#mdlLocationMaster").modal("show");
        });
        $('#btnCancelLocation').click(function () {
            cancelLocationMasterForm();
            CUI.setDatatableMaxHeight();
        });
        $("#frmLocationMaster").submit(function (e) {
            e.preventDefault();
            saveLocationMaster();
        });
        $('#tblLocationMaster tbody').on('click', 'tr', function () {
            dis_se_lectUserRow($(this));
        });
        $('#btnEditLocationMaster').click(function () {
            editLocationMaster();
        });
        $('#btnDeleteLocationMaster').click(function () {
            Location.msg = "Are you sure you want to delete this Location?";
            Location.confirmAction().then(function (approve) {
                if (approve)
                    deleteLocation();
            });
        });
        //#Special Events
        tblLocationMaster.on('draw.dt', function () {
            CUI.dataTableID = "#tblLocationMaster";
            CUI.setDatatableMaxHeight();
        });
        $.listen('parsley:field:error', function (fieldInstance) {//Parsley Validation Error Event Listener
            setTimeout(function () { CUI.setDatatableMaxHeight(); }, 500);
        });
        //#Functions Here-------------------------------------------------------------------------------------------------------------------
        function drawDatatables() {
            if (!$.fn.DataTable.isDataTable('#tblLocationMaster')) {
                tblLocationMaster = $('#tblLocationMaster').DataTable({
                    processing: true,
                    serverSide: true,
                    "order": [[0, "asc"]],
                    "pageLength": 25,
                    "ajax": {
                        "url": "/MasterMaintenance/LocationMaster/GetLocationList",
                        "type": "POST",
                        "datatype": "json",
                    },
                    responsive: true,
                    dataSrc: "data",
                    columns: [
                        { title: "Area", data: 'Area' },

                        { title: "Position", data: 'Position' },
                        { title: "X", data: 'X' },
                        { title: "Y", data: 'Y' },
                        { title: "Z", data: 'Z' },
                        { title: "Pallet Capacity", data: 'PalletCapacity' },
                        { title: "Box Capacity", data: 'BoxCapacity' },
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
        function saveLocationMaster() {
            Location.formData = $('#frmLocationMaster').serializeArray();
            Location.formAction = '/MasterMaintenance/LocationMaster/SaveLocation';
            Location.setJsonData().sendData().then(function () {
                tblLocationMaster.ajax.reload(null, false);
                cancelLocationMasterTbl();
                cancelLocationMasterForm();
            });
        }
        function cancelLocationMasterForm() {
            Location.clearFromData("frmLocationMaster");
            //$('#Username').prop('readonly', false);
            //$("#mdlUserTitle").text(" Create User");
            //$("#btnSaveUser .btnLabel").text(" Save");
            //$("#Role option[value='Custom']").remove();
            $("#mdlLocationMaster").modal("hide");
        }
        function cancelLocationMasterTbl() {
            $('#btnEditLocationMaster').attr("disabled", "disabled");
            $('#btnDeleteLocationMaster').attr("disabled", "disabled");
        }
        function dis_se_lectUserRow(LocationRow) {
            if (LocationRow.data("id")) {
                if (LocationRow.hasClass('selected')) {
                    LocationRow.removeClass('selected');
                    //Username = "";
                    ID = 0;
                    $('#btnEditLocationMaster').attr("disabled", "disabled");
                    $('#btnDeleteLocationMaster').attr("disabled", "disabled");
                }
                else {
                    tblLocationMaster.$('tr.selected').removeClass('selected');
                    LocationRow.addClass('selected');
                    //Username = ItemRow.data("username");
                    ID = LocationRow.data("id");
                    $('#btnEditLocationMaster').removeAttr("disabled");
                    $('#btnDeleteLocationMaster').removeAttr("disabled");
                }
            }
            else {
                alert('else');
            }
        }
        function editLocationMaster() {
            Location.formAction = '/MasterMaintenance/LocationMaster/GetLocationDetails';
            if (Location.formAction) {
                Location.jsonData = { ID: ID };
                Location.sendData().then(function () {
                    populateLocationData(Location.responseData.locationData);
                });
            } else {
                Location.showError("Please try again.");
            }
        }
        function populateLocationData(location) {
        /* $('#PartNumber').prop('readonly', true);*/
            $("#frmLocationMaster").parsley().reset();
            $("#mdlLocationMasterTitle").text(" Update Location");
            $("#btnSaveLocation .btnLabel").text(" Update");
            Location.populateToFormInputs(location, "#frmLocationMaster");
            $("#mdlLocationMaster").modal("show");
        }
        function deleteLocation() {
            Location.formAction = '/MasterMaintenance/LocationMaster/DeleteLocation';
            Location.jsonData = { ID: ID };
            Location.sendData().then(function () {
                tblLocationMaster.ajax.reload(null, false);
                cancelLocationMasterTbl();
                cancelLocationMasterForm();
            });
        }
    });
})();
