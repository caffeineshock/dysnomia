$('#calendar').fullCalendar({
  editable: true,
  header: {
    left: 'prev,next today',
    center: 'title',
    right: 'month,agendaWeek,agendaDay'
  },
  defaultView: 'month',
  height: 500,
  slotMinutes: 15,

  loading: function(bool){
    if (bool)
      showSpinner();
    else
      hideSpinner();
  },

  eventRender: function(event) {
    removeUnread("event", [event.id]);
  },

  buttonText: {
    today:    'Heute',
    month:    'Monat',
    week:     'Woche',
    day:      'Tag'
  },

  monthNames: [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'August',
    'September',
    'Oktober',
    'November',
    'Dezember'
  ],

  monthNamesShort: ['Jan','Feb','Mär','Apr','Mai','Jun','Jul','Aug','Sept','Okt','Nov','Dez'],
  
  dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
  
  dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],

  allDayText: "ganztägig",

  weekNumberTitle: "KW",

  axisFormat: 'HH:mm',

  weekNumbers: true,

  firstDay: 1,

  lang: "de",

  timezone: 'UTC',

  // a future calendar might have many sources.
  eventSources: [{
    url: '/events'
  }],

  //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
  eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
    updateEvent(event);
  },

  // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
  eventResize: function(event, dayDelta, minuteDelta, revertFunc){
    updateEvent(event);
  },

  // http://arshaw.com/fullcalendar/docs/mouse/dayClick/
  dayClick: function(date, allDay, jsEvent, view){
    window.location = "/events/new?start=" + date / 1000;
  },
});

var updateEvent = function(the_event) {
  $.ajax({
    url:  "/events/" + the_event.id,
    type: 'PUT',
    contentType: 'application/json',
    data: JSON.stringify({
      event: {
        starts_at: "" + the_event.start.toISOString(),
        ends_at: "" + the_event.end.toISOString()
      }
    }),
    dataType: 'json'
  });
};