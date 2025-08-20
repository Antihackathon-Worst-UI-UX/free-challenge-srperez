var vs_target = 1;
switch state {
	case "waiting":
		var lx = x;
		x = xstart;
		
		if (y >= floor_y) {
			y = floor_y;
			vsp = bounce_vsp;
		}
		
		x = lx;
		
		var mouse_points_at = function(target) {
			with target {
				return (abs(mouse_x - x) < sprite_width / 2 and abs(mouse_y - y) < sprite_height / 2);
			}
		}
		
		depth = layer_get_depth("rocks") - 50 + (y / sys.game_size) * 50;
		
		if (mouse_points_at(id) and !sys.click_taken) {
			var hover = true;
			with obj_work_rock {
				if ((state == "drag" or state == "on-workshop") or (y < other.y and mouse_points_at(id))) hover = false;
			}
			
			if (hover) {
				vs_target = 1.2;
			
				if (mouse_check_button_pressed(mb_left)) {
					sys.click_taken = true;
					mouse_xoff = x - mouse_x;
					mouse_yoff = y - mouse_y;
					state = "drag";
					order_floors();
					break;
				}
			}
		}
		
		
		
		
		break;
		
		case "drag":
			x = mouse_x + mouse_xoff;
			y = mouse_y + mouse_yoff;
			depth = layer_get_depth("rocks") - 60;
			
			vs_target = 0.8;
			
			var touching_workshop = place_meeting(x, y, obj_taller_workshop);
			var touching_rocks = place_meeting(x, y, obj_work_rock);
			
			if (touching_workshop or touching_rocks) {
				vs_target = 1.2;
			}
			if (!mouse_check_button(mb_left)) {
				sys.click_taken = false;
				if (touching_workshop) {
					state = "on-workshop";
				}
				else if (touching_rocks) {
					state = "waiting";
				}
				else {
					state = "falling";
				}
				break;
			}
		break;
		
		case "on-workshop":
			x += (marker_x(2) - x) / 8;
			y += (marker_y(2) - y) / 8;
		break;
		
		case "falling":
			if (place_meeting(x, y, obj_floor) or place_meeting(x, y, obj_key)) {
				var bpos = [[-1, -1], [1, -1], [-1, 1], [1, 1]];
				for (var i = 0; i < array_length(bpos); i++) {
					rock_break(x + sprite_width * 0.25 * bpos[i][0], y + sprite_height * 0.25 * bpos[i][1], 0.5);
				}
				
				instance_destroy();
				
			}
		break;
}

visual_scale += (vs_target - visual_scale) / 6;

image_alpha = obj_taller.image_alpha;