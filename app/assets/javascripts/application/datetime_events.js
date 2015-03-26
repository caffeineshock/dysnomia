$.turboInit(function () {
  $('select.datetime').on('focus change', function (event) {
    var container = $(this).parent("div");
    container.trigger('datetime.' + event.type, container.getDate());
  });
});

(function($){
  $.fn.getDate = function (){
    var values = {};

    $(this).children('select').each(function () {
      values[$(this).attr("id").substr(-2)] = $(this).val();
    });

    return new Date(
      values['2i'] + " " +
      values["3i"] + ", " +
      values["1i"] + " " +
      values["4i"] + ":" +
      values["5i"] + ":00"
    );
  };

  $.fn.setDate = function (date){
    var selects = {};

    $(this).children('select').each(function () {
      selects[$(this).attr("id").substr(-2)] = $(this);
    });

    selects["1i"].val(date.getFullYear());
    selects["2i"].val(date.getMonth() + 1);
    selects["3i"].val(date.getDate());
    selects["4i"].val(("0" + date.getHours()).substr(-2));
    selects["5i"].val(("0" + date.getMinutes()).substr(-2));
  };
})(jQuery);
