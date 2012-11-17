$ jQuery ->
 $('.navigation li').each ->
   if window.location.href.indexOf($(@).find('a:first').attr('href')) > -1
    $(@).addClass('active').siblings().removeClass 'active'

 $('.inline-container form, .side-module-share form').on 'click', ->
  $(@).addClass 'active'
