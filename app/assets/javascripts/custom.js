$(function(){
    $('.navbar li, .dropdown-menu li').each(function(){
      if(window.location.href.indexOf($(this).find('a:first').attr('href'))>-1)
        {
          if($(this).parents(".navbar").length > 0)
            $(this).addClass('active').siblings().removeClass('active');
          else
            $(this).removeClass('active')
        }
    });

    $('.inline-container form, .side-module-share form').on('click', function(){
      $(this).addClass('active');
    });
});
