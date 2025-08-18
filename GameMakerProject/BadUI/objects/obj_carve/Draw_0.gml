draw_sprite_ext(spr_rock, 0, x, y, rscale, rscale, 0, c_white, image_alpha);

for (var i = 0; i < array_length(carved_points); i++) {
	var p = carved_points[i];
	draw_set_color(c_black);
	draw_circle(p[0], p[1], carve_size * 0.9, false);
}

#region debug
/*

for (var i = 0; i < array_length(border_points); i++) {
	var p = border_points[i];
	draw_set_color(c_lime);
	draw_circle(x - rock_size / 2 + p[0], y - rock_size / 2 + p[1], rscale / 2, false);
}

for (var i = 0; i < array_length(fill_points); i++) {
	var p = fill_points[i];
	draw_set_color(c_white);
	draw_circle(x - rock_size / 2 + p[0], y - rock_size / 2 + p[1], rscale / 2, false);
}

for (var i = 0; i < array_length(garbage_points); i++) {
	var p = garbage_points[i];
	draw_set_color(c_purple);
	draw_circle(x - rock_size / 2 + p[0], y - rock_size / 2 + p[1], rscale / 2, false);
}
*/
#endregion

draw_set_color(c_white);

var letOff = 0;//letSize * letScale * 0.5;
var letColor = c_black//merge_color(c_black, c_white, (1 + dsin(timer * 3)) * 0.5);
var a = image_alpha * (0.1 + 0.1 * dsin(timer * 2));

draw_sprite_ext(spr_letters, letter * 2, x - letOff, y - letOff, letScale, letScale, 0, letColor, a);

draw_sprite_ext(spr_drill, 0, drill_x, drill_y, 1, 1, drill_angle, merge_color(c_white, c_red, clamp(stress / max_stress, 0, 1)), image_alpha);
/*draw_set_color(c_lime);
draw_circle(tip_x, tip_y, tip_size, false);
*/

var acc_string = "Bordes: " + string(acc.borders)
acc_string += "\nRelleno: " + string(acc.fill)
acc_string += "\nBasura removida: " + string(acc.garbage)

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(x, y + rock_size / 2 + 48, acc_string);

draw_set_halign(fa_left);

timer++;