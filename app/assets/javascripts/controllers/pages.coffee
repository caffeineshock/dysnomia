$('.js-task-list-container').taskList 'enable'
$('.edit_page').bind 'ajax:success', ->
  hideSpinner()
$(document).bind 'tasklist:changed', ->
  showSpinner()
  $('.edit_page').submit()
