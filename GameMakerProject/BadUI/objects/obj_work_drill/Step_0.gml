var vs_target = 1;

var x_to = x;
var y_to = y;

switch state {
	case "waiting":
		image_angle += (-180 - image_angle) / 6;
		dir = 1;
		
		x_to = xstart;
		y_to = ystart;
		if (collision_point(mouse_x, mouse_y, id, true, false) != noone and !sys.click_taken) {
			vs_target = 1.2;
			
			if (mouse_check_button_pressed(mb_left)) {
				state = "drag";
				sys.click_taken = true;
				break;
			}
		}
	break;
	
	case "drag":
		dir = -1;
		image_angle += (110 - image_angle) / 6;
		
		x_to = mouse_x;
		y_to = mouse_y;
		
		var ow = place_meeting(x, y, obj_taller_workshop);
		
		with obj_taller {
			if (!workshop_ready) ow = false;
		}
		
		if (ow) vs_target = 1.2;
		
		if (!mouse_check_button(mb_left)) {
			sys.click_taken = false;
			if (ow) {
				pivot_x = x;
				pivot_y = y;
				state = "on-workshop";
				
				with (obj_game) {
					state = "workshop-init-trans";
				}
				break;
			}
			
			state = "waiting";
			break;
		}
	break;
	
	case "on-workshop":
		pivot_x += (marker_x(5) - pivot_x) / 12;
		pivot_y += (marker_y(5) - pivot_y) / 12;
		image_speed = 30;
		x = pivot_x + random_range(-5, 5);
		y = pivot_y + random_range(-5, 5);
	break;
}

v_scale += (vs_target - v_scale) / 6;
x += (x_to - x) / 6;
y += (y_to - y) / 6;

image_xscale = scale * dir;
image_yscale = scale;

image_alpha = obj_taller.image_alpha;