$("#channel_user_ids").select2();

$("#channel_public").on('change', function () {
	sync_user_select_with_checkbox($(this));
});

sync_user_select_with_checkbox($("#channel_public"));

function sync_user_select_with_checkbox(checkbox) {
	var subscribers = $('.channel_users');
	
	if (checkbox.prop("checked")) {
		subscribers.hide();
	} else {
		subscribers.show();
	}
}