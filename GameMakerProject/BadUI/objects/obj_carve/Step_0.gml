function tip_in_block() {
	if (abs(tip_x - x) > rock_size / 2 or abs(tip_y - y) > rock_size / 2)
		return false;
	return true;
}

function tip_collision() {
	if (!tip_in_block()) return false;
	
	for (var i = 0; i < array_length(carved_points); i++) {
		var p = carved_points[i];
		var d = point_distance(p[0], p[1], tip_x, tip_y)
		if (carve_size > d + tip_size) {
			return false;
		}
	}
	return true;
}

function tip_recalc() {
	var tip_ang = drill_angle + 90 + 23;
	var tip_length = 180;
	tip_x = drill_x + dcos(tip_ang) * tip_length
	
	tip_y = drill_y - dsin(tip_ang) * tip_length;
}

if (!drill_on) {
	drill_x += (mouse_x - drill_x) / 6;
	drill_y += (mouse_y - drill_y) / 6;
	drill_angle += (angle_difference(0, drill_angle) / 6);
}
else {
	var ang = point_direction(drill_x, drill_y, mouse_x, mouse_y);
	var dist = min(point_distance(drill_x, drill_y, mouse_x, mouse_y) / 4, 4);
	drill_x += dcos(ang) * dist;
	drill_y -= dsin(ang) * dist;
	
	var yaw_diff = angle_difference(0, drill_angle) / 4;
	drill_angle += clamp(yaw_diff, -2, 2);
}


drill_on = mouse_check_button(mb_left);

if (point_distance(mouse_x, mouse_y, lmouse_x, lmouse_y) > 200) {
	pause_drill = true;
}

if (pause_drill) {
	drill_on = false;
	if (point_distance(drill_x, drill_y, mouse_x, mouse_y) < tip_size) pause_drill = false;
}

if (mouse_check_button_pressed(mb_left)) {
	stress += tween_exp(0, 10, random_range(0, 1));
}

if (drill_on) {
	drill_y += random_range(-1, 1) * 5;
	drill_angle += random_range(-1, 1);
}

tip_recalc();


var do_carve = tip_collision();
if (drill_on) {
	if (do_carve) {
		array_push(carved_points, [tip_x, tip_y])
		var stress_mov =  (tip_size / max_stress) * 2 * stress;
		var dvdir = random_range(-1, 1);
		var dhdir = random_range(-1, 1);
		
		var target_x = drill_x;
		var target_y = drill_y;
		
		target_y += tween_exp(0, stress_mov, abs(dvdir)) * dvdir;
		target_x += tween_exp(0, stress_mov, abs(dhdir)) * dhdir;
		
		var dadir = random_range(-1, 1)
		var stress_ang = (45 / max_stress) * stress;
		
		var target_ang = drill_angle;
		target_ang += tween_exp(0, stress_ang, abs(dadir)) * dadir;
		
		var res = 3;
		var steps = point_distance(drill_x, drill_y, target_x, target_y) / res;
		var init_x = drill_x;
		var init_y = drill_y;
		var init_ang = drill_angle;
		
		for (var i = 0; i < steps; i++) {
			var t = i / steps;
			drill_x = tween_linear(init_x, target_x, t);
			drill_y = tween_linear(init_y, target_y, t);
			drill_angle = tween_linear(init_ang, target_ang, t);
			tip_recalc();
			if (tip_in_block())
				array_push(carved_points, [tip_x, tip_y]);
		}
	}
	stress+= 0.1;
	if (stress > max_stress) stress = max_stress;
}
else {
	stress -= 0.2;
	if (stress < 0) stress = 0;
}

if (image_alpha < 1) {
	image_alpha += 0.1;
}

lmouse_x = mouse_x;
lmouse_y = mouse_y;