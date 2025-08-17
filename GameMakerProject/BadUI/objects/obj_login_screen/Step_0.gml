var stZoomOut = function(time) {
	var t = time;
	scale = tween_ease(1, 225 / 1024, t);
	x = tween_ease(room_width / 2, sprite_get_xoffset(spr_desk), t);
	y = tween_ease(room_height / 2, sprite_get_yoffset(spr_desk), t);
}

var stChange = function(to) {
	state_timer = -1;
	state = to;
}

switch state {
	case "idle":
		if keyboard_check_pressed(ord("Z")) {
			stZoomOut(1);
			stChange("game-init");
			break;
		}
		
		if (mouse_check_button_pressed(mb_left)) {
			stChange("waiting");
			break;
		}
	break;
	
	case "waiting":
		
		
		
		if (mouse_check_button_pressed(mb_left)) {
			waiting_clicks++;
			state_timer = 0;
		}
		
		if (state_timer >= 60 * 3 or waiting_clicks >= 3) {
			stChange("zoom-out");
			recenter();
			break;
		}
		
		if (state_timer % 2 == 0) {
			var hdir = random_range(-1, 1);
			var vdir = random_range(-1, 1);
			
			var max_shake = 60;
			var shake = max(max_shake - state_timer, 0) / max_shake;
			x = xstart + shake * 20 * hdir;
			y = ystart + shake * 20 * vdir;
		}
	break; 
	
	case "zoom-out":
		var t = state_timer / 60 / 8;
		stZoomOut(t);
		
		if (t >= 1) {
			stChange("game-init");
		}
	break;
	
	case "game-init":
		instance_create_layer(x, y, "game", obj_game);
		stChange("game");
	break;
}

state_timer++;