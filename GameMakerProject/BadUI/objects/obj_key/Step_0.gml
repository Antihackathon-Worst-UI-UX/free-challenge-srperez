function manage_drag() {
	if (sys.click_taken) return false;
	if (collision_point(mouse_x, mouse_y, self, true, false) != noone) {
		hover_scale += (1.2 - hover_scale) / 12;
		if (mouse_check_button_pressed(mb_left)) {
			state = "dragging";
			off_x = x - mouse_x;
			off_y = y - mouse_y;
			sys.click_taken = true;
			return true;
		}
	}
	else {
		hover_scale += (1 - hover_scale) / 12;
	}
	return false;
}

switch state {
	case "waiting":
		image_angle = spin + dcos(sys.frame * 4) * 15;
		x += (xstart - x) / 6;
		y += (ystart - y) / 6;
		spin += (0 - spin) / 6;
		scale += (scale_normal - scale) / 6;
		
		if manage_drag() break;
	break;
	
	case "dragging":
		hover_scale += (1 - hover_scale) / 6;
		x += ((mouse_x + off_x) - x) / 6;
		y += ((mouse_y + off_y) - y) / 6;
		
		var sc = scale_normal * 0.7;
		
		var touching_workshop = place_meeting(x, y, obj_taller_table);
		var touching_table = place_meeting(x, y, obj_taller_workshop);
		
		if (touching_workshop or touching_table) sc = scale_normal;
		
		scale += (sc - scale) / 6;
		
		if (!mouse_check_button(mb_left)) {
			sys.click_taken = false;
			if (touching_workshop) {
				state = "waiting";
				var sdir = 1;
				if (letter % 4 == 0) sdir = -1;
				spin = 360 * 1.5 * sdir;
				letter += 2;
				letter %= sprite_get_number(spr_letters);
				
				break;
			}
			else if (touching_table) {
				state = "on-workshop";
				break;
			}
			else {
				state = "falling";
				vsp = mouse_y - lmouse_y;
				hsp = mouse_x - lmouse_x;
				break;
			}
		}
	break;
	
	case "on-workshop":
		if (manage_drag()) break;
		x += (marker_x(1) - x) / 6;
		y += (marker_y(1) - y) / 6;
		image_angle += (-5 - image_angle) / 6;
		
		scale += (0.3 - scale) / 6;
	break;
	
	case "falling":
		if (manage_drag()) {
			vsp = 0;
			hsp = 0;
			break;
		}
		
		vsp += grav;
		x += hsp * 3;
		y += vsp * 3;
		
		var randHor = random_range(0.2, 2);
		
		if (place_meeting(x, y, obj_floor)) {
			while (place_meeting(x, y, obj_floor)) y--;
			vsp = random_range(-15, -6);
			if (sign(hsp) == 0) hsp = 1;
			
			hsp = 5 * randHor * sign(hsp);
		}
		
		
		if (x < -room_width) {
			hsp = 5 * randHor;
		}
		if (x > 0) {
			hsp = -5 * randHor;
		}
		
		if (y < 0) {
			vsp = abs(vsp);
		}
		
		image_angle -= (hsp);
		
		x = clamp(x, -room_width, 0);
		y = clamp(y, 0, room_height);
		
	break;
}

image_alpha = obj_taller.image_alpha;
image_xscale = scale;
image_yscale = scale;

lmouse_x = mouse_x;
lmouse_y = mouse_y;