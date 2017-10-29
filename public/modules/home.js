/**
 * Created by Barind on 18/10/17.
 */
$(document).ready(function() {
    $.toast({
        heading: 'Selamat Datang di ' + ProjectName,
        text: Description,
        position: 'top-right',
        loaderBg: '#ff6849',
        icon: 'info',
        hideAfter: 3500,

        stack: 6
    })
});


$('ul.pagination').hide();
$(function() {
    $("#loadMore").click(function() {
        $('.infinite-scroll').jscroll({
            autoTrigger: true,
            loadingHtml: '<img class="center-block" src="'+ BASE_URL +'/images/loading.gif" alt="Loading..." />',
            padding: 0,
            nextSelector: '.pagination li.active + li a',
            contentSelector: 'div.infinite-scroll',
            callback: function() {
                $('ul.pagination').remove();
            }
        });
    });
});

$(".counter").counterUp({
    delay: 100,
    time: 1200
});
