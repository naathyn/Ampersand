$ jQuery ->
 $('.navigation li').each ->
   if window.location.href.indexOf($(@).find('a:first').attr('href')) > -1
    $(@).addClass('active').siblings().removeClass 'active'

 $('.side-module-share form, .inline-container form, .modal-form form').on 'click', ->
  $(@).addClass 'active'
