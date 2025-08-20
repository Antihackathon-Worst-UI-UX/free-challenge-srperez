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

logout_y = 200;
forget_y = 400;

error_message = "";

x_drag = 0;
y_drag = 0;
scale_drag = 0;

logged_in = false;

if (file_exists("details.txt")) {
	var f = file_text_open_read("details.txt")
	var g = instance_create_layer(x, y, "game", obj_game);
	g.username = file_text_read_string(f);
	file_text_close(f);
	
	logged_in = true;
	with all {
		state = "end";
	}
	
	with obj_carved_rock {
		instance_destroy();
	}
}