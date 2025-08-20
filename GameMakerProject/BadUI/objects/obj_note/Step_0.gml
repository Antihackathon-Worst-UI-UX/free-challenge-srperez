image_alpha = lerp(image_alpha, alpha_fun(), 0.2);
image_alpha = clamp(image_alpha, 0, 1);

var hs_target = 1;
if (!sys.click_taken and !instance_exists(obj_carve)) {
	if (collision_point(mouse_x, mouse_y, id, true, false) != noone) {
		hs_target = 1.2;
		
		if (mouse_check_button_pressed(mb_left)) {
			sys.click_taken = true;
			is_open = true;
			exit;
		}
	}
}

if (is_open) {
	content_alpha += 0.05;
	if (mouse_check_button_pressed(mb_left)) {
		sys.click_taken = false;
		is_open = false;
		exit;
	}
	depth = layer_get_depth("note_content");
}
else {
	depth = layer_get_depth("notes");
	content_alpha -= 0.05;
}

content_alpha = clamp(content_alpha, 0, 1);

hover_scale = lerp(hover_scale, hs_target, 0.3);