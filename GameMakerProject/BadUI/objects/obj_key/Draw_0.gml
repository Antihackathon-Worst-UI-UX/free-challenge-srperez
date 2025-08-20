
if (index_to_letter(letter) == "*") {
	soul_length += 0.02;
}
else {
	soul_length -= 0.02;
}

soul_length = clamp(soul_length, 0, 1);

if (soul_length > 0) {
	var sep = 100;
	var souls = 6;
	for (var i = 0; i < souls; i++) {
		var ang = sys.frame * 2 + (360 / souls) * i;
		var jx = dcos(ang) * sep * soul_length;
		var jy = -dsin(ang) * sep * soul_length;
		draw_sprite_ext(spr_letters, letter, x + jx, y + jy, image_xscale * 0.4, image_yscale * 0.4, 0, sys.col_font, image_alpha * 0.5 * soul_length);
	}
}

draw_sprite_ext(spr_letters, letter, x, y, image_xscale * hover_scale, image_yscale * hover_scale, image_angle, sys.col_font, image_alpha);