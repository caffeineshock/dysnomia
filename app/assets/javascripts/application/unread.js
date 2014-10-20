$(function() {
	PrivatePub.subscribe('/unread/' + window.current_tenant, function (data, channel) {
		if (data.model == "message" && window.muted_channels.indexOf(data.channel) >= 0) {
			return;
		}

    	switch(data.type) {
    		case "add":
    			if (data.source != window.current_user) {
    				addUnread(data.model, [data.id]);
    			}

    		break;

    		case "remove":
    			removeUnread(data.model, [data.id]);

    		break;
    	}
  	});
});

var updateSpan = function(model, newArray) {
	newCount = newArray.length;
	oldCount = unread[model].length;
	span = $('#' + model + '_notifications');
	icon = $('#' + model + '_icon');

	if (oldCount < newCount) {
		span.html(newCount.toString());

		if (oldCount == 0) {
			span.stop(true).fadeIn();	
			icon.stop(true).hide();
		} else {
			span.stop(true).effect("pulsate", {times: 1}, 1500);
		}
	} else if (oldCount > newCount) {
		if (newCount == 0) {
			span.stop(true).fadeOut(function () {
				icon.stop(true).show();
			});
		} else {
			span.html(newCount.toString());
			prevBgColor = span.css("backgroundColor");
			prevFontSize = span.css("fontSize");
			span.stop(true).animate({
				backgroundColor: "#aa0000"
			}, 150, function() {
	            $(this).stop(true).animate({
	                backgroundColor: prevBgColor
	            }, 300);
            });
		}
	}

	unread[model] = newArray;
};

var removeUnread = function(model, toRemove) {
	newArray = $(unread[model]).not(toRemove).get();
	updateSpan(model, newArray);	
};

var addUnread = function(model, toAdd) {
	newArray = $(unread[model]).not(toAdd).get();

	for (var i = 0; i < toAdd.length; i++) {
		newArray.push(toAdd[i]);
	}

	updateSpan(model, newArray);
};