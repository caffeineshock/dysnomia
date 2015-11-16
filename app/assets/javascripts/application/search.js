$.turboInit(function() {
	$(document).on('opened', '[data-reveal]', function () {
		input = $("#searchbox-field");
		
		if (!input.val()) {
			input.focus();	
		} else {
			input.select();
		}  		
	});
	$(".navbar-search-button").click(function() {
	  $(".search-box").foundation('reveal', 'open');
	});
});