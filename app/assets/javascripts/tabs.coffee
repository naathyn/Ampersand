jQuery ->
  $(".nav-tabs a").click (e) ->
    e.preventDefault()
    $(@).tab "show"
   # Triggers bootstraps tabs when clicked
