jQuery(document).ready(function() {
    $(".select2").select2();

    $('.pre-selected-options').multiSelect();
    $('#optgroup').multiSelect({
        selectableOptgroup: true
    });

});
