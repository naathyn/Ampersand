$(function () {
    $('.side-module-share form, .inline-container form').on('click', function () {
        $(this).addClass('active');
    });

   $('.wysihtml5').each(function(i, elem) {
      $(elem).wysihtml5();
    });
});
