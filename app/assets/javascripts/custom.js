$(function(){
    $('.navbar li').each(function(){
      if(window.location.href.indexOf($(this).find('a:first').attr('href'))>-1)
        {
      $(this).addClass('active').siblings().removeClass('active');
        }
    });

    $('.dropdown-menu li').each(function(){
      if(window.location.href.indexOf($(this).find('a:first').attr('href'))>-1)
        {
      $(this).removeClass('active')
        }
    });

    $('.inline-container form, .side-module-share form').on('click', function(){
      $(this).addClass('active');
    });
});
