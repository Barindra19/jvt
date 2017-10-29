/**
 * Created by Barind on 27/09/17.
 */

/* SETELAH PILIH REGION */
$("#region").change( function() {
    $.post(
        BASE_URL + '/country/searchbyregion',
        {
            region_id       : $(this).val(),
            _token          : CSRF_TOKEN
        },
        function(msg) {
            $("#country").html(msg).show();

            $.post(
                BASE_URL + '/destination/searchbycountry',
                {
                    region_id       : $('#region').val(),
                    country_id      : 0,
                    _token : CSRF_TOKEN
                },
                function(msg) {
                    $("#destination").html(msg).show();
                });
        });
});
/* SETELAH PILIH REGION */

/* SETELAH PILIH COUNTRY */
$("#country").change( function() {
    $.post(
        BASE_URL + '/destination/searchbycountry',
        {
            region_id       : $('#region').val(),
            country_id      : $(this).val(),
            _token : CSRF_TOKEN
        },
        function(msg) {
            $("#destination").html(msg).show();
        });
});
/* SETELAH PILIH COUNTRY */

$("#btn-addBanner").click(function() {
    var id              = $('#id').val();
    $('#tour_id').val(id);
    $('#addBanner').modal('show');
});


$("form#form_upload").submit(function(){
    var formData = new FormData(this);
    $.ajax({
        url: BASE_URL + '/tour/admin/upload',
        type: 'POST',
        data: formData,
        async: false,
        success: function (data) {
            var json = JSON.parse(data);
            if(json.status == true){
                $("#loadBanner").load( BASE_URL + "/tour/admin/load/" + json.tour_id);
                $.toast({
                    heading: 'Berhasil',
                    text: json.message,
                    icon: 'success',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    hideAfter: 3500
                });

                var drEvent = $('#banner').dropify();
                drEvent = drEvent.data('dropify');
                drEvent.resetPreview();
                drEvent.clearElement();
            }else{
                if(json.info){
                    $.toast({
                        heading: 'Perhatian!',
                        text: json.message,
                        icon: 'warning',
                        position: 'top-right',
                        loaderBg:'#ff6849',
                        hideAfter: 3500
                    });

                }else{
                    $.toast({
                        heading: 'Gagal',
                        text: json.message,
                        icon: 'error',
                        position: 'top-right',
                        loaderBg:'#ff6849',
                        hideAfter: 3500
                    });
                }
            }
        },
        cache: false,
        contentType: false,
        processData: false
    });
    return false;
});

function ResetForm() {
    $("#region").select2('val', "0");
    $("#country").select2('val', "0");
    $("#destination").select2('val', "0");
}

$("#btn-ResetFormSearch").click(function() {
    $("#type").select2('val', "0");
    ResetForm();
    $.toast({
        heading: 'Pemberitahuan',
        text: "Reset Form Berhasil",
        icon: 'success',
        position: 'top-right',
        loaderBg:'#ff6849',
        hideAfter: 3500
    });
});

$("#type").change( function() {
    console.log($(this).val());
    if($(this).val() == 4){ /* CUSTOME TRIP */
        $('#filter').hide();
        ResetForm();
    }else if($(this).val() == 1){ /* HOT OFFER */
        $('#filter').hide();
        ResetForm();
    }else if($(this).val() == 3){ /* OPEN TRIP */
        $('#filter').show();
    }else if($(this).val() == 2){ /* PRVATE TRIP */
        $('#filter').show();
    }
});
