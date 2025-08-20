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

window_set_cursor(cr_default);

var lstate = state;

var lx = x;
var ly = y;
var lscale = scale;

switch state {
	case "idle":
		if keyboard_check_pressed(ord("S")) {
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
	
	case "zoom-out-quick":
		var t = state_timer / 60;
		stZoomOut(t);
		
		if (t >= 1) {
			stChange("game-init");
		}
	break;
	
	case "game-init":
		instance_create_layer(x, y, "game", obj_game);
		stChange("game");
	break;
	
	case "game":
		if (instance_number(obj_carved_rock) > 0) {
			
			if (!sys.click_taken and obj_game.state == "desk" and abs(mouse_x - x) < 128 and abs(mouse_y - y) < 128) {
				hover_limit++;
				window_set_cursor(cr_handpoint);
				if (mouse_check_button_pressed(mb_left)) {
					stChange("try-trans");
					hover_limit = 0;
					obj_game.state = "desk-try-init";
					break;
				}
			}
			else {
				hover_limit -= 0.5;
				
			}
			hover_limit = clamp(hover_limit, 0, string_length(hover_text));
		}
	break;
	
	case "try-trans":
		var trans_time = 60;
		stZoomOut((trans_time - state_timer) / trans_time);
		
		if (state_timer >= trans_time) {
			btt_back = add_button(100, sys.game_size - 100, "volver", 1, function() {
				state = "try-detrans";
				state_timer = 0;
			});
			stChange("try");
			break;
		}
	break;
	
	case "try":
		if (abs(mouse_x - x) < 256 and abs(mouse_y - (y + login_y)) < 64) {
			
			login_hover += 0.1;
			
			if (mouse_check_button_pressed(mb_left)) {
				login_hover = 0;
				
				if (string_length(obj_game.username) < 5) {
					error_message = "Username must be at least 5 characters long.";
					if (obj_game.username == "") error_message = "Username is required.";
				}
				else if (!password) {
					error_message = "Password is required.";
				}
			}
		}
		else {
			login_hover -= 0.1;
		}
		
		login_hover = clamp(login_hover, 0, 1);
	break;
	
	case "try-detrans":
		var detrans_time = 60;
		stZoomOut(state_timer / detrans_time);
		
		if (state_timer >= detrans_time) {
			stChange("game");
			obj_game.state = "desk-init";
		}
	break;
}

state_timer++;

if (lstate != state) state_timer = 0;

x_drag = (x - lx);
y_drag = (y - ly);
scale_drag = (scale - lscale);