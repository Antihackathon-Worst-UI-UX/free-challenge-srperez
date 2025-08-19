

var lstate = state;

function cam_move(time = 60) {
	cam_x = tween_ease(cam_prev_x, cam_target_x, state_timer / time);
	cam_y = tween_ease(cam_prev_y, cam_target_y, state_timer / time);
	cam_size = tween_ease(cam_prev_size, cam_target_size, state_timer / time);
	
	if (state_timer >= time) {
		cam_prev_x = cam_target_x;
		cam_prev_y = cam_target_y;
		cam_prev_size = cam_target_size;
	}
}



switch state {
	case "desk-init":
		add_button(100, 100, "taller", 1, function() {
			state = "taller-init";
			tween_alpha(obj_login_screen, 0, 30);
			//instance_create_layer(x, y, layer, obj_carve);
		})
		state = "desk";
		cam_prev_x = cam_x;
		cam_target_x = 0;
	break;
	
	case "desk":
		cam_move();
		if (state_timer == 30) tween_alpha(obj_login_screen, 1, 60);
	break;
	
	case "taller-init":
		add_button(-100, room_height - 100, "volver", -1, function() {
			state = "desk-init";
			tween_alpha(obj_taller, 0, 30);
			//instance_create_layer(x, y, layer, obj_carve);
		})
		state = "taller";
		cam_prev_x = cam_x;
		cam_target_x = - room_width;
	break;
	
	case "taller":
		cam_move();
		if (state_timer == 30) tween_alpha(obj_taller, 1, 60);
		
		if (keyboard_check_pressed(vk_space)) {
			state = "workshop-trans";
			tween_alpha(obj_taller, 0, 60);
			cam_prev_x = cam_x;
			cam_prev_y = cam_y;
			cam_prev_size = cam_size;
			
			cam_target_x = marker_left(2);
			cam_target_y = marker_top(2);
			cam_target_size = marker_width(2);
		}
	break;
	
	case "workshop-trans":
		var duration = 60;
		cam_move(duration);
		if (state_timer >= duration) {
			cam_x = 0;
			cam_y = 0;
			cam_size = sys.game_size;
			var carve = instance_create_layer(sys.game_size / 2, sys.game_size / 3, "game", obj_carve);
			carve.letter = obj_key.letter / 2;
			state = "workshop";
			break;
		}
		
	break;
	
	case "workshop":
		if (!instance_exists(obj_carve)) {
			cam_x = cam_target_x
			cam_y = cam_target_y;
			cam_size = cam_target_size;
			
			cam_target_x = -sys.game_size;
			cam_target_y = 0;
			cam_target_size = sys.game_size;
			
			tween_alpha(obj_taller, 1, 60);
			state = "workshop-detrans";
		}
	break;
	
	case "workshop-detrans":
		var duration = 60;
		cam_move(duration);
		if (state_timer >= duration) {
			state = "taller";
			break;
		}
	break;
}

state_timer ++;
if (lstate != state) {
	state_timer = 0;
}

camera_set_view_pos(view_camera[0], cam_x, cam_y);
camera_set_view_size(view_camera[0], cam_size, cam_size);