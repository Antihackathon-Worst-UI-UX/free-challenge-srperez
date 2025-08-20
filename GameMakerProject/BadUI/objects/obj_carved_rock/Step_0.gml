image_xscale = scale;
image_yscale = scale;

x = rx;
y = ry;

if (index_to_letter(letter_index) == "*") {
	special = true;
}

if (special) {
	var sep = 100;
	var soul_targets = [];
	for (var i = 0; i < souls; i++) {
		if (state != "placed") {
			var ang = sys.frame * 2 + (360 / souls) * i;
			var jx = dcos(ang) * sep;
			var jy = -dsin(ang) * sep;
			soul_targets[i] = [jx, jy, 0.4, 0.8];
		}
		else {
			soul_targets[i] = [120 * (i + 1), 0, 0.85, 0.9];
		}
	}
	
	for (var i = 0; i < souls; i++) {
		var dat = soul_data[i];
		var tar = soul_targets[i]
		for (var j = 0; j < array_length(dat); j++) {
			dat[j] = lerp(dat[j], tar[j], 0.3);
		}
	}
}

var total_rocks = (array_length(obj_game.carved_letters) - 1);
if (total_rocks <= 0) total_rocks = 1;
var rock_sep = sys.game_size * 0.65 / total_rocks;
var table_x = marker_x(3) + rock_sep * letter_rock_index;
var table_y = marker_y(3);

var wave_move = function() {
	y = ry + dsin(sys.frame * 3 + letter_rock_index * 25) * 4 * scale;	
}

var lstate = state;

var alpha = -1;

hs_target = 1;



switch state {
	case "idle":
		wave_move();
		
		alpha = obj_taller.image_alpha;
		
		if (state_timer >= 60) {
			state = "float-trans";
			break;
		}
		
	break;
	
	case "float-trans":
		var duration = 120;
		wave_move();
		rx = tween_ease(xstart, table_x, state_timer / duration);
		ry = tween_ease(ystart, table_y, state_timer / duration);
		
		alpha = max(obj_taller.image_alpha, obj_login_screen.image_alpha);
		
		if (state_timer >= duration) {
			state = "waiting";
			break;
		}
		
	break;
	
	case "waiting":
		wave_move();
		rx += (table_x - rx) / 6;
		ry += (table_y - ry) / 6;
		
		if (obj_login_screen.state == "try") {
			if (!sys.click_taken) {
				if (collision_point(mouse_x, mouse_y, id, true, false) != noone) {
					hs_target = 1.2;
				
					if (mouse_check_button_pressed(mb_left)) {
						sys.click_taken = true;
						state = "dragging";
						break;
					}
				}
			}
		}
	break;
	
	case "dragging":
		rx = lerp(rx, mouse_x, 0.3);
		ry = lerp(ry, mouse_y, 0.3);
		
		var fpos = obj_login_screen.field_positions;
		
		var in_user = abs(ry - fpos[0]) < 64;
		var in_pass = abs(ry - fpos[1]) < 64;
		
		var in_field = (special and in_pass) or (!special and in_user);
		
		if (in_field) hs_target = 1.2;
		
		if (!mouse_check_button(mb_left)) {
			calc_username();
			if (in_field) {
				place_x = mouse_x;
				place_y = mouse_y;
				
				if (special) {
					place_y = fpos[1];
					place_x = 128;
				}
				
				state = "placed";
				calc_username();
				array_delete(obj_game.carved_letters, letter_rock_index, 1);
				array_push(obj_game.carved_letters, id);
					
				with obj_carved_rock {
					for (var i = 0; i < array_length(obj_game.carved_letters); i++) {
						if (obj_game.carved_letters[i] == id) {
							letter_rock_index = i;
							break;
						}
					}
				}
				image_angle = random_range(-5, 5);
				sys.click_taken = false;
				break;
			}
			sys.click_taken = false;
			state = "waiting";
			break;
		}
	break;
	
	case "placed":
		var shake_time = 30;
		var shake = max(shake_time - state_timer, 0) / shake_time * 10;
		rx = lerp(rx, place_x, 0.5);
		ry = lerp(ry, place_y, 0.5);
		
		x = rx + random_range(-shake, shake);
		y = ry + random_range(-shake, shake);
		
		if (!sys.click_taken) {
			if (collision_point(mouse_x, mouse_y, id, true, false) != noone) {
				hs_target = 1.2;
				
				if (mouse_check_button_pressed(mb_left)) {
					sys.click_taken = true;
					image_angle = 0;
					state = "dragging";
					break;
				}
			}
		}
		
		if (obj_login_screen.state != "try") {
			state = "waiting";
			calc_username();
			image_angle = 0;
			break;
		}
	break;
}

if (alpha != -1) image_alpha = alpha;
else image_alpha = obj_login_screen.image_alpha;

hover_scale = lerp(hover_scale, hs_target, 1/6);

state_timer++;
if (lstate != state) state_timer = 0;

var xd = 0;
var yd = 0;
var sd = 0;

with obj_login_screen {
	xd = x_drag;
	yd = y_drag;
	sd = scale_drag;
}

var mf = 0.75;
x += yd * (x - obj_login_screen.x) * 0.1 * mf;
y += yd * 40 * mf;
scale = normal_scale + sd * 50;