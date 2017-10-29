/**
 * Created by Barind on 17/10/17.
 */
$(document).ready(function() {
    $(document).ready(function() {
        var table = $('#tbl_classtour').DataTable({
            "ajax"            : ROUTE_DATATABLE,
            "columns"         : [
                {"data" : "id"},
                {"data" : "name"},
                {"data" : "is_active", "width":"70px"},
                {"data" : "href", "width":"150px"}
            ],
            "columnDefs": [{
                "visible": false,
                "targets": 0
            },
            {
                "targets": 3,
                "orderable": false
            }
            ],
            "order": [
                [0, 'asc']
            ],
            "displayLength": 25,
            "bLengthChange": false,
            responsive: true
        });

    });
});
