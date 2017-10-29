/**
 * Created by Barind on 28/09/17.
 */


var TableDatatablesColreorder = function () {

    var initTable = function () {
        var table_variable = $('#tbl_news');
        var oTable = table_variable.dataTable({
            "ajax"            : ROUTE_DATATABLE,
            "bInfo": false,
            "columns"         : [
                {"data" : "id"},
                {"data" : "title", "width":"60%"},
                {"data" : "is_active", "width":"10%"},
                {"data" : "date_active", "width":"15%"},
                {"data" : "href", "width":"15%"}
            ],
            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ entries",
                "infoEmpty": "No entries found",
                "infoFiltered": "(filtered1 from _MAX_ total entries)",
                "lengthMenu": "_MENU_ entries",
                "search": "Search:",
                "zeroRecords": "No matching records found"
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // setup buttons extentension: http://datatables.net/extensions/buttons/
            buttons: [
            ],

            // setup responsive extension: http://datatables.net/extensions/responsive/
            responsive: true,
            "bLengthChange": false,
            // setup colreorder extension: http://datatables.net/extensions/colreorder/
            colReorder: {
                reorderCallback: function () {
                    console.log( 'callback' );
                }
            },

            "columnDefs": [
                {
                    "targets": 0,
                    "visible": false
                },
                {
                    "targets": 3,
                    "orderable": false
                },
                {
                    "targets": 4,
                    "orderable": false
                },


            ],

            "order": [
                [0, 'desc']
            ],

            "lengthMenu": [
                [5, 10, 15, 20, -1],
                [5, 10, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 10,

            "dom": "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row' <'col-md-12'T>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
        });


    }

    return {

        //main function to initiate the module
        init: function () {

            if (!jQuery().dataTable) {
                return;
            }
            initTable();
        }

    };

}();

jQuery(document).ready(function() {
    TableDatatablesColreorder.init();
});
