$(document).on 'page:fetch', ->
  showSpinner()

$(document).on 'page:change', ->
  hideSpinner()