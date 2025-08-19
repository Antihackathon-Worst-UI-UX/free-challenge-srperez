if (!surface_exists(rock_surface)) {
	rock_surface = surface_create(sys.rock_size, sys.rock_size);
	if (rock_surface == -1) exit;
	
	var rscale = sys.rock_size / sprite_get_width(spr_rock);
	surface_set_target(rock_surface);
	draw_sprite_ext(spr_rock, 0, sys.rock_size / 2, sys.rock_size / 2, rscale, rscale, 0, c_white, 1);
	
	
	
	
	var ccol = [sys.col_carve, c_black];
	var bmode = [bm_normal, bm_subtract];
	var hole = [1.2, 0.9];
	
	for (var l = 0; l < 2; l++) {
		gpu_set_blendmode(bmode[l]);
		for (var i = 0; i < array_length(carved_points); i++) {
			var p = carved_points[i];
			draw_set_color(ccol[l]);
			draw_circle(p[0], p[1], sys.carve_size * hole[l], false);
		}
	}
	
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}



var draw_me = function(col, xoff, yoff) {
	var surScale = sprite_get_width(spr_rock) / sys.rock_size * scale;
	var surSize = sys.rock_size * surScale;
	draw_surface_ext(rock_surface, xoff + x - surSize / 2, yoff + y - surSize / 2, surScale, surScale, 0, col, image_alpha);
}

var outPos = [[0, 1], [1, 0], [0, -1], [-1, 0]];
for (var i = 0; i < array_length(outPos); i++) {
	draw_me(c_black, 2 * outPos[i][0] * scale, 2 * outPos[i][1] * scale);
}

draw_me(c_white, 0, 0);