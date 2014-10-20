var categoryColor = function(state) {
  var originalOption = state.element;
  return '<span class="category-indicator" style="background: ' + $(originalOption).data('color') + '; box-shadow: 0 0 5px ' + $(originalOption).data('color') + '"/>' + state.text;
}

$("#event_category_id").select2({
  formatResult: categoryColor,
  formatSelection: categoryColor,
  escapeMarkup: function(m) { return m; }
});

$("#event_recurring_type").select2({
  minimumResultsForSearch: -1,
  placeholder: "Art der Wiederholung",
  allowClear: true
});

$("#event_user_ids").select2();

$('.event_starts_at').on('datetime.focus', function (event, date) {
  $(this).data('datetime', date);
}).on('datetime.change', function (event, newStartDate) {
   var oldStartDate = $(this).data('datetime');
   var oldDuration = $('.event_ends_at').getDate().getTime() - oldStartDate.getTime(); 
   $('.event_ends_at').setDate(new Date(newStartDate.getTime() + oldDuration));
});