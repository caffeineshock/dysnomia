$.turboInit = (callback) ->
  $(document).on 'ready', callback
  $(document).on 'page:load', callback