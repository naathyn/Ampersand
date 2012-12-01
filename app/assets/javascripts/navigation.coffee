jQuery ->
  $('.navigation li').each ->
    if window.location.href.indexOf($(@).find('a:first').attr('href')) > -1
      $(@).addClass('active').siblings().removeClass 'active'
   # Adds active class to navbar links in respect to the current page
