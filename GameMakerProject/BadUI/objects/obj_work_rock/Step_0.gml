switch state {
	case "waiting":
		var target_h = room_height;
		var coll = [];
		var lx = x;
		x = xstart;
		if (vsp > 0) {
			with obj_work_rock {
				if (state == "waiting" and id != other.id and place_meeting(xstart, y, other) and y > other.y) array_push(coll, id);
			}
		}
		x = lx;
		
		array_sort(coll, function(r1, r2) {return r1.y - r2.y})
		
		if (array_length(coll) > 0) target_h = coll[0].y - 32;
		
		if (target_h > floor_y) target_h = floor_y;
		if (y < target_h) {
			vsp += grav;
			height += vsp;
		}
		else {
			if (abs(vsp) < 4) {
				vsp = 0;
				y = target_h;
			}
			else {
				vsp *= -0.25;
				y = target_h - 2;
			}
		}
		
		y += vsp;
		var yaw = dsin(sys.frame * 4 + y) * (floor_y - y) / 48;
		image_angle = -yaw * 0.1;
		x = xstart + yaw;
		break;
}

image_alpha = obj_taller.image_alpha;