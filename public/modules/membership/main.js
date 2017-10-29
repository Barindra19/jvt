/**
 * Created by Barind on 23/10/17.
 */


/* SETELAH PILIH LEVEL */
$("#level").change( function() {
    if($(this).val() > 0){
        $.post(
            BASE_URL + '/level/searchbylevel',
            {
                level_id       : $(this).val(),
                _token          : CSRF_TOKEN
            },
            function(result) {
                var data = JSON.parse(result);

                if(data.output.param_level_caption == 'Cabang'){
                    $("#cabang").select2('val',"0");
                    $("#masterdistributor").select2('val',"0");
                    $("#distributor").select2('val',"0");
                    $('#filtercabang').hide();
                    $('#filtermasterdistributor').hide();
                    $('#filterdistributor').hide();
                }else if(data.output.param_level_caption == 'Master Distributor'){
                    $('#filtercabang').show();
                    $("#cabang").html(data.output.users).show();

                    $("#masterdistributor").select2('val',"0");
                    $("#distributor").select2('val',"0");
                    $('#filtermasterdistributor').hide();
                    $('#filterdistributor').hide();

                }else if(data.output.param_level_caption == 'Distributor'){
                    if(data.output.level_user == 1){ // USER SISTEM //
                        $('#filtercabang').show();
                        $("#cabang").html(data.output.users).show();
                        $('#filtermasterdistributor').hide();
                        $("#masterdistributor").select2('val',"0");

                        $("#distributor").select2('val',"0");
                        $('#filterdistributor').hide();

                    }else if(data.output.level_user == 2){ // USER CABANG //
                        $('#filtercabang').hide();
                        $("#cabang").select2('val',"0");
                        $('#filtermasterdistributor').show();
                        $("#masterdistributor").html(data.output.users).show();

                        $("#distributor").select2('val',"0");
                        $('#filterdistributor').hide();

                    }else if(data.output.level_user == 3){ // USER MASTER DISTRIBUTION //
                        $('#filtercabang').hide();
                        $("#cabang").select2('val',"0");
                        $('#filtermasterdistributor').hide();
                        $("#masterdistributor").select2('val',"0");

                        $("#distributor").html(data.output.users).show();
                        $('#filterdistributor').show();
                    }


                }else if(data.output.param_level_caption == 'Agen'){
                    if(data.output.level_user == 1){ // USER SISTEM //
                        $('#filtercabang').show();
                        $("#cabang").html(data.output.users).show();
                        $('#filtermasterdistributor').hide();
                        $("#masterdistributor").select2('val',"0");

                        $("#distributor").select2('val',"0");
                        $('#filterdistributor').hide();
                    }else if(data.output.level_user == 2){ // USER CABANG //
                        $('#filtercabang').hide();
                        $("#cabang").select2('val',"0");
                        $('#filtermasterdistributor').show();
                        $("#masterdistributor").html(data.output.users).show();
                        $("#distributor").select2('val',"0");
                        $('#filterdistributor').hide();

                    }else if(data.output.level_user == 3){ // USER MASTER DISTRIBUTOR //
                        $('#filtercabang').hide();
                        $("#cabang").select2('val',"0");
                        $('#filtermasterdistributor').hide();
                        $("#masterdistributor").select2('val',"0");

                        $("#distributor").html(data.output.users).show();
                        $('#filterdistributor').show();
                    }

                }else{
                    $('#filtercabang').hide();
                    $("#cabang").select2('val',"0");

                    $("#masterdistributor").select2('val',"0");
                    $('#filtermasterdistributor').hide();

                    $("#distributor").select2('val',"0");
                    $('#filterdistributor').hide();
                }
            });
    }

});
/* SETELAH PILIH LEVEL */


/* SETELAH PILIH CABANG */
$("#cabang").change( function() {
    if($(this).val() > 0){
        $.post(
            BASE_URL + '/level/searchbycabang',
            {
                user_id         : $(this).val(),
                level_id        : $('#level').val(),
                _token          : CSRF_TOKEN
            },
            function(result) {
                var data = JSON.parse(result);
                if($('#level').val() > 3){
                    $('#filtermasterdistributor').show();
                    $("#masterdistributor").html(data.output.users).show();
                }
            });
    }
});

/* SETELAH PILIH CABANG */


/* SETELAH PILIH MASTER DISTRIBUTOR */
$("#masterdistributor").change( function() {
    if($(this).val() > 0) {
        $.post(
            BASE_URL + '/level/searchbymasterdistributor',
            {
                user_id: $(this).val(),
                level_id: $('#level').val(),
                _token: CSRF_TOKEN
            },
            function (result) {
                var data = JSON.parse(result);
                if ($('#level').val() > 4) {
                    $('#filterdistributor').show();
                    $("#distributor").html(data.output.users).show();
                }
            });
    }
});
/* SETELAH PILIH MASTER DISTRIBUTOR */

