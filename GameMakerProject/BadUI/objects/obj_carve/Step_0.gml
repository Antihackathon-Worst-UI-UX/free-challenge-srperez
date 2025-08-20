function tip_in_block() {
	if (abs(tip_x - x) > rock_size / 2 or abs(tip_y - y) > rock_size / 2)
		return false;
	return true;
}

function cullPass(callback = function(xx, yy) {}) {
	for (var i = rscale / 2; i < rock_size; i += rscale) {
		for (var j = rscale / 2; j < rock_size; j += rscale) {
			var result = callback(i, j);
			if (result) return true;
		}
	}
	return false;
}

function dotPass(dot_array, callback = function(xx, yy, dotInd) {}) {
	for (var i = 0; i < array_length(dot_array); i++) {
		var p = dot_array[i];
		
		var result = callback(p[0], p[1], i);
		if (result) return true;
	}
	return false;
}

function tip_collision() {
	if (!tip_in_block()) return false;
	
	
	if (dotPass(carved_points, function(xx, yy) {
		var d = point_distance(xx, yy, tip_x, tip_y)
		if (carve_size > d + tip_size) {
			return true;
		}
		return false;
	})) {
		return false;
	}
	return true;
}

function tip_recalc() {
	var tip_ang = drill_angle + 90 + 23;
	var tip_length = 180;
	tip_x = drill_x + dcos(tip_ang) * tip_length
	
	tip_y = drill_y - dsin(tip_ang) * tip_length;
}

function collider_start() {
	var collider = instance_create_layer(rock_size / 2, rock_size / 2, layer, obj_lettercollider);
	collider.image_xscale = letScale;
	collider.image_yscale = letScale;
	collider.image_index = letter * 2;
	return collider;
}

function collider_end() {
	instance_destroy(obj_lettercollider);
}

function point_carve(point_ref, xx, yy) {
	__x = xx - x + rock_size / 2;
	__y = yy - y + rock_size / 2;
	remove_points = [];
	
	dotPass(point_ref, function(xxx, yyy, dotInd) {
		if (point_distance(__x, __y, xxx, yyy) <= rscale / 2 + tip_size) {
			array_push(remove_points, dotInd);
		}
	});
		
	var removed = 0;
	for (var i = 0; i < array_length(remove_points); i++) {
		array_delete(point_ref, remove_points[i] - removed, 1);
		removed++;
	}
}

function accuracy_calc() {
	dotPass(new_dots, function(xx, yy) {
		point_carve(border_points, xx, yy);
		point_carve(fill_points, xx, yy);
		point_carve(garbage_points, xx, yy);
	});
	
	
	acc.borders = 1 - (array_length(border_points) / border_total);
	acc.fill = (array_length(fill_points) / fill_total);
	acc.garbage = 1 - (array_length(garbage_points) / garbage_total)
	
	new_dots = [];
}

var doneFun = function() {
	var rock = instance_create_layer(marker_x(2), marker_y(2), "carved_letters", obj_carved_rock);
	__rock_points = [];
	dotPass(carved_points, function(xx, yy, dotId) {
		array_push(__rock_points, [xx - x + rock_size / 2, yy - y + rock_size / 2]);
	});
	rock.carved_points = __rock_points;
	rock.letter_index = letter * 2;
					
	array_push(obj_game.carved_letters, rock);
	instance_destroy();
};

if (border_total == 0) {
	collider = collider_start();
	
	cullPass(function(xx, yy) {
		if (collision_circle(xx, yy, rscale / 2, collider, true, true) != noone) {
			array_push(border_points, [xx, yy]);
		}
		else {
			collider.image_index++;
			if (collision_circle(xx, yy, rscale / 2, collider, true, true) != noone) {
				array_push(fill_points, [xx, yy]);
			}
			else {
				array_push(garbage_points, [xx, yy]);
			}
			collider.image_index--;
		}
		return false;
	});
	
	collider_end();
	
	border_total = array_length(border_points);
	fill_total = array_length(fill_points);
	garbage_total = array_length(garbage_points);
	
	accuracy_calc();
}


var progress = {
	border : (acc.borders / min_acc.borders),
	fill : ((acc.fill - min_acc.fill) / (1 - min_acc.fill)),
	garbage : (acc.garbage / min_acc.garbage)
}

var lstate = state;
switch state {
	case "carving":
		if (image_alpha < 1) {
			image_alpha += 0.1;
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

		var do_carve = tip_collision();

		if (mouse_check_button_pressed(mb_left) and do_carve) {
			stress += tween_exp(5, 10, random_range(0, 1));
		}

		if (drill_on) {
			drill_y += random_range(-1, 1) * 5;
			drill_angle += random_range(-1, 1);
			
			drill_spd += 10;
		}
		else {
			drill_spd --;
		}

		tip_recalc();



		if (drill_on) {
			if (do_carve) {
				array_push(new_dots, [tip_x, tip_y])
				rock_break(tip_x, tip_y);
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
						array_push(new_dots, [tip_x, tip_y]);
						
					if (i % 8 == 0) {
						rock_break(tip_x, tip_y);
					}
				}
		
				carved_points = array_concat(carved_points, new_dots);
				accuracy_calc();
			}
			stress+= 0.1;
			if (stress > max_stress) stress = max_stress;
		}
		else {
			stress -= 0.2;
			if (stress < 0) stress = 0;
		}

		if (mouse_check_button_released(mb_left)) {
			accuracy_calc();
		}
		
		if (progress.fill <= 0) {
			state = "breaking-rock";
			if (instance_exists(done_btt)) done_btt.killed = true;
			break;
		}
		
		if (keyboard_check(ord("S")) and keyboard_check_pressed(vk_space)) doneFun();
		if (progress.border >= 1 and progress.garbage >= 1) {
			if (!instance_exists(done_btt)) {
				done_btt = add_button(sys.game_size - 100, 100, "Listo", -1, doneFun);
			}
		}
	break;
	
	case "breaking-rock":
		drill_spd--;
		var break_time = 40;
		var break_wait = 40;
		var break_total = break_time + break_wait;
		
		bar_alpha = tween_linear(1, 0, state_timer / (break_total * 0.75));
		if (state_timer % 2 == 0) {
			var intensity = clamp(break_time - state_timer, 0, break_time);
			x = xstart + random_range(-intensity, intensity);
			y = ystart + random_range(-intensity, intensity);
		}
		
		if (state_timer >= break_total) {
			dotPass(array_concat(border_points, garbage_points, fill_points), function(xx, yy) {
				var xPixel = floor(xx / rscale);
				var yPixel = floor(yy / rscale);
				
				if (xPixel % 4 == 1 and yPixel % 4 == 1) {
					rock_break(xx + x - rock_size / 2, yy + y - rock_size / 2, 2);
				}
			})
			state = "broken";
			break;
		}
	break;
	
	case "broken":
		image_alpha -= 0.05;
		
		if (state_timer >= 80) {
			instance_destroy();
		}
	break;
}

drill_spd = clamp(drill_spd, 0, 30);

drill_img += drill_spd / 60;

state_timer++;
if (state != lstate) state_timer = 0;


bar_values[0] += (progress.border - bar_values[0]) / 12;
bar_values[1] += (progress.fill - bar_values[1]) / 12;
bar_values[2] += (progress.garbage - bar_values[2]) / 12;



lmouse_x = mouse_x;
lmouse_y = mouse_y;