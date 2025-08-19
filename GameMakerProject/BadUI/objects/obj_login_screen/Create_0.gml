scale = 1;
recenter = function() {
	x = room_width / 2;
	y = room_height / 2;
	xstart = x;
	ystart = y;
}

recenter();

state = "idle";

waiting_clicks = 0;
state_timer = 0;

layer_set_visible("desk_test", false);