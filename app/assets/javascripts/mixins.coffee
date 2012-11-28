jQuery ->

  $('.navigation li').each ->
    if window.location.href.indexOf($(@).find('a:first').attr('href')) > -1
      $(@).addClass('active').siblings().removeClass 'active'
   # Adds active class to navbar links in respect to the current page
 
  $('.side-module-share form, .inline-container form').on 'click', ->
    $(@).addClass 'active'
   # Adds height to forms when clicked

  $(".likes").tooltip html: true
   # Enables html with bootstrap tooltips (likes)
 
  $(".captchas").tooltip html: true,
  delay: 
    show: 250, 
    hide: 250
   # Enables html with bootstrap tooltips (captchas)

  $(".nav-tabs a").click (e) ->
    e.preventDefault()
    $(@).tab "show"
   # Triggers bootstraps tabs when clicked
