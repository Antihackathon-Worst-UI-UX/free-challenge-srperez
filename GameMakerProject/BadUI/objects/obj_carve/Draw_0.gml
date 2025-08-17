var rsize = sprite_get_width(spr_rock);
var rscale = rock_size / rsize;
draw_sprite_ext(spr_rock, 0, x, y, rscale, rscale, 0, c_white, image_alpha);

for (var i = 0; i < array_length(carved_points); i++) {
	var p = carved_points[i];
	draw_set_color(c_black);
	draw_circle(p[0], p[1], carve_size * 0.9, false);
}

draw_sprite_ext(spr_drill, 0, drill_x, drill_y, 1, 1, drill_angle, merge_color(c_white, c_red, clamp(stress / max_stress, 0, 1)), image_alpha);
/*draw_set_color(c_lime);
draw_circle(tip_x, tip_y, tip_size, false);
*/