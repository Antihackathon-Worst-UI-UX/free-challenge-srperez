if (!killed) {
	if (image_alpha < 1) image_alpha += 0.1;
	
	if (point_distance(x, y, mouse_x, mouse_y) < sprite_get_width(sprite_index) / 2) {
		select_timer ++;
		
		if (mouse_check_button(mb_left)) {
			action();
			killed = true;
		}
	}
	else {
		select_timer --;
	}
	
	select_timer = clamp(select_timer, 0, select_max);
}
else {
	image_alpha -= 0.1;
	if (image_alpha < 0) instance_destroy();
}