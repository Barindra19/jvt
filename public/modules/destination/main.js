/**
 * Created by Barind on 27/09/17.
 */

$('#country').select2({
    minimumInputLength: 3,
    ajax: {
        url: BASE_URL + '/country/searchbyregionid',
        dataType: 'json',
        type: "POST",
        data: function (term) {
            return {
                term            : term,
                region_id       : $('#region').val(),
                _token          : CSRF_TOKEN
            };
        },
        processResults: function (data) {
            return {
                results: $.map(data, function (item) {
                    return {
                        text: item.name,
                        slug: item.name,
                        id: item.id
                    }
                })
            };
        }
    }
});

