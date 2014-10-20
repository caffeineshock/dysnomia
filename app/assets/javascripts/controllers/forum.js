$(window).resize(function() {
	$('#discourse').height($(window).height() - 49);
});

$(window).trigger('resize');