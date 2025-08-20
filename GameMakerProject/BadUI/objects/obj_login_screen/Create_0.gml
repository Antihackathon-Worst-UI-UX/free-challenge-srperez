scale = 1;
hover_limit = 0;
recenter = function() {
	x = room_width / 2;
	y = room_height / 2;
	xstart = x;
	ystart = y;
}

recenter();

state = "idle";

if (file_exists("rocks.txt")) {
	state = "zoom-out-quick";
}

waiting_clicks = 0;
state_timer = 0;

layer_set_visible("desk_test", false);

hover_text = "INTENTARLO?";

btt_back = noone;

field_positions = [0, 0];

login_y = 100;
login_hover = 0;

error_message = "";

x_drag = 0;
y_drag = 0;
scale_drag = 0;