jQuery ->

  $('.navigation li').each ->
    if window.location.href.indexOf($(@).find('a:first').attr('href')) > -1
      $(@).addClass('active').siblings().removeClass 'active'
   # Adds active class to navbar links in respect to the current page

  $('.page-fade').addClass 'active'
   # Adds a fade to the home and show pages on load in conjuntion with transtions
