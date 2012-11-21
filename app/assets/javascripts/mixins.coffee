$ ->

  $('.navigation li').each ->
    if window.location.href.indexOf($(@).find('a:first').attr('href')) > -1
      $(@).addClass('active').siblings().removeClass 'active'
   # Adds active class to navbar links in respect to the current page
 
  $('.side-module-share form, .inline-container form').on 'click', ->
    $(@).addClass 'active'
   # Adds height to forms when clicked
 
  $(".over").tooltip html: true
   # Enables html with bootstrap tooltips
