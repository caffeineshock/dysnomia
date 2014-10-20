function postprocess(text) {
  var result;
  $.ajax({
    type: 'POST',
    url: '/postprocess',
    data: text,
    success: function (response) {
      result = response;
    },
    async: false
  });
  return result;
};

(function($){
  $.fn.postprocess = function (){
    $(this).html(postprocess($(this).text()));
  };
})(jQuery);