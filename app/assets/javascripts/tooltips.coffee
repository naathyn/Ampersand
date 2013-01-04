jQuery ->
  $(".likes, captchas").tooltip html: true
  $(".captchas").tooltip
    delay: 
      show: 250, 
      hide: 250
   # Triggers bootstraps tooltips on hover
