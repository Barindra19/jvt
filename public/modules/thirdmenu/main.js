$(document).ready(function() {
    $("#menu").change( function() {
        $.post(
            BASE_URL + '/submenu/searchbymenu',
        {
            menu_id : $(this).val(),
            _token : CSRF_TOKEN
        },
        function( msg ) {
            $("#submenu").html(msg).show();
            $("#loadsubmenu").html('');
        });
    });
});
