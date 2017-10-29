/**
 * Created by Barind on 21/10/17.
 */
$("#btn-AddKeagenan").click(function() {
    var id = $('#id').val();
    ResetForm();
    $('#level_id').val(id);
    $('#statusform').val('add');
    $('#komisi_id').val(0);
    $('#FormKomisiKeagenan').modal('show');
});


$("#btn-AddTransaksi").click(function() {
    var id = $('#id').val();
    ResetForm();
    $('#statusform').val('add');
    $('#level_id').val(id);
    $('#komisi_id').val(0);
    $('#FormKomisiKeagenan').modal('show');
});

function ResetForm() {
    $("#komisi_type").select2('val', "0");
    $("#level").select2('val', "0");
    $('#komisi').val("");
}

$("form#form_komisi").submit(function(){
    var formData = new FormData(this);
    $.ajax({
        url: BASE_URL + '/level/komisi/save',
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
                trHTML += '<td>' + json.output.level + '</td>';
                trHTML += '<td>' + json.output.komisi + '</td>';
                if(json.output.komisi_type_id == 1){
                    trHTML += '<td><a href="javascript:void(0);" class="btn btn-outline-primary btn-rounded" onclick="editKeagenan('+ json.output.id +')"><i class="fa fa-edit"></i></a> <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteKeagenan('+ json.output.id +')"><i class="fa fa-trash"></i></a></td>';
                }else if(json.output.komisi_type_id == 2){
                    trHTML += '<td><a href="javascript:void(0);" class="btn btn-outline-primary btn-rounded" onclick="editTransaksi('+ json.output.id +')"><i class="fa fa-edit"></i></a> <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteTransaksi('+ json.output.id +')"><i class="fa fa-trash"></i></a></td>';
                }
                trHTML += '</tr>';
                if(json.output.komisi_type_id == 1){
                    $('#tbl_komisi_keagenan').append(trHTML);
                }else if(json.output.komisi_type_id == 2){
                    $('#tbl_komisi_transaksi').append(trHTML);
                }
                $('#FormKomisiKeagenan').modal('hide');
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

function editKeagenan(id){
    $.ajax({
        url: BASE_URL + "/level/komisi/get",
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

                $("#komisi_type").select2('val', ""+json.output.komisi_type_id+"");
                $("#level").select2('val', ""+json.output.level+"");

                $('#komisi').val(json.output.komisi);
                $('#level_id').val(json.output.level_id);
                $('#komisi_id').val(id);
                $('#statusform').val('edit');
                $('#FormKomisiKeagenan').modal('show');
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

function editTransaksi(id) {
    $.ajax({
        url: BASE_URL + "/level/komisi/get",
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

                $("#komisi_type").select2('val', ""+json.output.komisi_type_id+"");
                $("#level").select2('val', ""+json.output.level+"");

                $('#komisi').val(json.output.komisi);
                $('#level_id').val(json.output.level_id);
                $('#komisi_id').val(id);
                $('#statusform').val('edit');
                $('#FormKomisiKeagenan').modal('show');
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

function deleteKeagenan(id){
    $('#id_delete_keagenan').val(id);
    $('#ConfirmDeleteKeagenan').modal('show');
}

$("#btn-DeleteKeagenan").click(function() {
    var id = $('#id_delete_keagenan').val();

    $.ajax({
        url: BASE_URL + "/level/komisi/delete",
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
                $('#ConfirmDeleteKeagenan').modal('hide');
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


function deleteTransaksi(id){
    $('#id_delete_transaksi').val(id);
    $('#ConfirmDeleteTransaksi').modal('show');
}



$("#btn-DeleteTransaksi").click(function() {
    var id = $('#id_delete_transaksi').val();

    $.ajax({
        url: BASE_URL + "/level/komisi/delete",
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
                $('#ConfirmDeleteTransaksi').modal('hide');
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
