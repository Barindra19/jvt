/**
 * Created by Barind on 26/10/17.
 */

$('#tour').select2({
    minimumInputLength: 3,
    ajax: {
        url: BASE_URL + '/tour/admin/get',
        dataType: 'json',
        type: "POST",
        data: function (term) {
            return {
                term            : term,
                region          : $('#region').val(),
                country         : $('#country').val(),
                destination     : $('#destination').val(),
                _token          : CSRF_TOKEN
            };
        },
        processResults: function (data) {
            return {
                results: $.map(data, function (item) {
                    return {
                        text: item.name + ' - ' + item.duration,
                        slug: item.name,
                        id: item.id
                    }
                })
            };
        }
    }
});


$("#btn-Add").click(function() {
    var id = $('#id').val();
    ResetForm();
    $('#open_trip_id').val(id);
    $('#statusform').val('add');
    $('#quota_id').val(0);
    $('#FormDetail').modal('show');
});

function ResetForm() {
    $("#tour_class").select2('val', "0");
    $('#cost_of_good').val("");
    $('#selling_price').val("");
    $('#quota').val("");
}



$("form#form_detail").submit(function(){
    var formData = new FormData(this);
    $.ajax({
        url: BASE_URL + '/opentrip/admin/save',
        type: 'POST',
        data: formData,
        async: false,
        success: function (data) {
            var json = JSON.parse(data);
            if(json.status == true){
                $.toast({
                    heading: 'Berhasil',
                    text: json.message,
                    icon: 'error',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    hideAfter: 3500
                });
                if(json.output.statusform == 'edit'){
                    $('#row-'+json.output.id).remove();
                }

                var trHTML      = '<tr id="row-'+ json.output.id +'">';
                trHTML += '<td>' + json.output.class_tour + '</td>';
                trHTML += '<td>' + json.output.cost_of_good + '</td>';
                trHTML += '<td>' + json.output.selling_price + '</td>';
                trHTML += '<td>' + json.output.quota + '</td>';
                trHTML += '<td>' + json.output.volume + '</td>';
                trHTML += '<td><a href="javascript:void(0);" class="btn btn-outline-primary btn-rounded" onclick="editDetail('+ json.output.id +')"><i class="fa fa-edit"></i></a> <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteDetail('+ json.output.id +')"><i class="fa fa-trash"></i></a></td>';
                trHTML += '</tr>';

                $('#tbl_quotas').append(trHTML);
                $('#FormDetail').modal('hide');
            }else{
                $.each( json.validator, function( key, value ) {
                    $.toast({
                        heading: 'Warning',
                        text: value,
                        icon: 'error',
                        position: 'top-right',
                        loaderBg:'#ff6849',
                        hideAfter: 3500
                    });
                    $('#row-' + key).addClass('has-error');
                });
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            $.toast({
                heading: 'Error',
                text: errorThrown,
                icon: 'error',
                position: 'top-right',
                loaderBg:'#ff6849',
                hideAfter: 3500
            });
        },
        cache: false,
        contentType: false,
        processData: false
    });

    return false;
});

function editDetail(id) {
    $.ajax({
        url: BASE_URL + "/opentrip/admin/get",
        type: 'POST',
        data: {
            id              : id,
            _token          : CSRF_TOKEN
        },
        success: function (data) {
            var json = JSON.parse(data);
            if(json.status == true){
                $.toast({
                    heading: 'Info',
                    text: json.message,
                    icon: 'info',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    hideAfter: 3500
                });

                $("#tour_class").select2('val', ""+json.output.class_tour+"");

                $('#cost_of_good').val(json.output.cost_of_good);
                $('#selling_price').val(json.output.selling_price);
                $('#open_trip_id').val(json.output.open_trip);
                $('#quota_id').val(id);
                $('#quota').val(json.output.quota);
                $('#pemesan').val(json.output.volume);
                $('#statusform').val('edit');
                $('#FormDetail').modal('show');
            }else{
                $.toast({
                    heading: 'Error',
                    text: json.message,
                    icon: 'error',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    hideAfter: 3500
                });
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            $.toast({
                heading: 'Error',
                text: errorThrown,
                icon: 'error',
                position: 'top-right',
                loaderBg:'#ff6849',
                hideAfter: 3500
            });
        }
    });
}




function deleteDetail(id){
    $('#id_delete').val(id);
    $('#ConfirmDelete').modal('show');
}

$("#btn-Delete").click(function() {
    var id = $('#id_delete').val();

    $.ajax({
        url: BASE_URL + "/opentrip/admin/deletedetail",
        type: 'POST',
        data: {
            id              : id,
            _token          : CSRF_TOKEN
        },
        success: function (data) {
            var json = JSON.parse(data);
            if(json.status == true){
                $.toast({
                    heading: 'Berhasil',
                    text: json.message,
                    icon: 'success',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    hideAfter: 3500
                });
                $('#row-'+json.id).remove();
                $('#ConfirmDelete').modal('hide');
            }else{
                $.toast({
                    heading: 'Error',
                    text: json.message,
                    icon: 'error',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    hideAfter: 3500
                });
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            $.toast({
                heading: 'Error',
                text: errorThrown,
                icon: 'error',
                position: 'top-right',
                loaderBg:'#ff6849',
                hideAfter: 3500
            });
        }
    });

});
