jQuery ->
  $('.side-module-share form, .inline-container form').on 'click', ->
    $(@).addClass 'active'
   # Adds height to forms when clicked
