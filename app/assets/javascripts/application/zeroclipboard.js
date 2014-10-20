$.turboInit(function() {
	new ZeroClipboard($('.zeroclipboard'));
});

$(document).on("page:before-change", function(){
  ZeroClipboard.destroy();
});