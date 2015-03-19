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

$("#event_all_day").change(function () {
  if($(this).is(":checked")) {
    $('#event_starts_at_4i').hide();
    $('#event_starts_at_5i').hide();
    $('#event_ends_at_4i').hide();
    $('#event_ends_at_5i').hide();
    $('.event_starts_at').addClass("time-disabled");
    $('.event_ends_at').addClass("time-disabled");
  } else {
    $('#event_starts_at_4i').show();
    $('#event_starts_at_5i').show();
    $('#event_ends_at_4i').show();
    $('#event_ends_at_5i').show();
    $('.event_starts_at').removeClass("time-disabled");
    $('.event_ends_at').removeClass("time-disabled");
  }
})

$("#event_all_day").trigger('change');

$('.event_starts_at').on('datetime.focus', function (event, date) {
  $(this).data('datetime', date);
}).on('datetime.change', function (event, newStartDate) {
   var oldStartDate = $(this).data('datetime');
   var oldDuration = $('.event_ends_at').getDate().getTime() - oldStartDate.getTime();
   $('.event_ends_at').setDate(new Date(newStartDate.getTime() + oldDuration));
});
