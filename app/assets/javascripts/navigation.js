$(function() {
    $('.page-fade').addClass('faade');

    $('.navigation li').each(function() {
        if (window.location.href.indexOf($(this).find('a:first').attr('href')) > -1) {
            $(this).addClass('active').siblings().removeClass('active');
        }
    });
});
