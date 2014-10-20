var showSpinner = function() {
	if ($("#nav-cover").length > 0) {
		return;
	}
	var opts = {
	  lines: 13, // The number of lines to draw
	  length: 0, // The length of each line
	  width: 5, // The line thickness
	  radius: 10, // The radius of the inner circle
	  corners: 1, // Corner roundness (0..1)
	  rotate: 0, // The rotation offset
	  direction: 1, // 1: clockwise, -1: counterclockwise
	  color: '#fff', // #rgb or #rrggbb or array of colors
	  speed: 1, // Rounds per second
	  trail: 100, // Afterglow percentage
	  shadow: true, // Whether to render a shadow
	  hwaccel: true, // Whether to use hardware acceleration
	  className: 'spinner', // The CSS class to assign to the spinner
	  zIndex: 2e9, // The z-index (defaults to 2000000000)
	  top: 'auto', // Top position relative to parent in px
	  left: 'auto' // Left position relative to parent in px
	};
	$("<div id=\"nav-cover\" />").css({
	    position: "absolute",
	    width: "100%",
	    height: "100%",
	    left: 0,
	    top: 0,
	    zIndex: 1000000,  // to be on the safe side
	    backgroundColor: "rgba(0, 0, 0, 0.5)"
	}).appendTo($("#navigation").css("position", "relative"));
	$("#navigation").spin(opts);
};

var hideSpinner = function() {
	if ($("#nav-cover").length == 0) {
		return;
	}
	$("#nav-cover").remove();
	$("#navigation").spin(false);
};