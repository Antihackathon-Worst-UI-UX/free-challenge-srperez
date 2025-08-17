var rsize = sprite_get_width(spr_rock);
var rscale = rock_size / rsize;


draw_sprite_ext(spr_rock, 0, x, y, rscale, rscale, 0, c_white, image_alpha);

for (var i = 0; i < array_length(carved_points); i++) {
	var p = carved_points[i];
	draw_set_color(c_black);
	draw_circle(p[0], p[1], carve_size * 0.9, false);
}

var letSize = sprite_get_width(spr_letters);
var letScale = rock_size / letSize;
var letOff = letSize * letScale * 0.5;
var letColor = c_black//merge_color(c_black, c_white, (1 + dsin(timer * 3)) * 0.5);
var a = image_alpha * (0.1 + 0.1 * dsin(timer * 2));

draw_sprite_ext(spr_letters, letter * 2, x - letOff, y - letOff, letScale, letScale, 0, letColor, a);

draw_sprite_ext(spr_drill, 0, drill_x, drill_y, 1, 1, drill_angle, merge_color(c_white, c_red, clamp(stress / max_stress, 0, 1)), image_alpha);
/*draw_set_color(c_lime);
draw_circle(tip_x, tip_y, tip_size, false);
*/

timer++;