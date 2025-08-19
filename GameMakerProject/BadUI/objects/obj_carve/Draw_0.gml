function drawRock() {
	draw_sprite_ext(spr_rock, 0, x, y, rscale, rscale, 0, c_white, image_alpha);

	for (var i = 0; i < array_length(carved_points); i++) {
		var p = carved_points[i];
		draw_set_color(c_black);
		draw_circle(x + p[0] - xstart, y + p[1] - ystart, carve_size * 0.9, false);
	}
}

switch state {
	case "carving":
		drawRock();
	break;
	
	case "breaking-rock":
		drawRock();
		var break_scale = rock_size / sprite_get_width(spr_broken_rock);
		draw_sprite_ext(spr_broken_rock, 0, x, y, break_scale, break_scale, 0, c_white, image_alpha);
	break;
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


/*draw_set_color(c_lime);
draw_circle(tip_x, tip_y, tip_size, false);
*/


bar_scale = 0.7;
bar_xoff = (1 - bar_scale) * sprite_get_width(spr_bar) * 0.5;

var draw_bar = function(yy, type, scale, txt) {
	scale = clamp(scale, 0, 1);
	var bar_center_x = sys.game_size / 2;
	var bar_center_y = yy + sprite_get_height(spr_bar) * bar_scale / 2;
	var bar_text_wave = 3;
	
	var barCol = merge_color(c_red, c_yellow, scale * 2);
	if (scale >= 0.5) barCol = merge_color(c_yellow, c_green, scale * 2 - 1);
	
	draw_sprite_part_ext(spr_bar, type * 2 + 1, 0, 0, scale * sprite_get_width(spr_bar), sprite_get_height(spr_bar), bar_xoff, yy, bar_scale, bar_scale, barCol, image_alpha * bar_alpha);
	draw_sprite_ext(spr_bar, type * 2, bar_xoff, yy, bar_scale, bar_scale, 0, sys.col_font, image_alpha * bar_alpha);
	
	draw_set_alpha(image_alpha * bar_alpha);
	text_render(txt, bar_center_x, bar_center_y, 0.2 * bar_scale, fa_center, fa_middle, bar_text_wave);
	draw_set_alpha(1);
}

var bar_padding = 10;
var bar_jump_y = bar_padding + sprite_get_height(spr_bar) * bar_scale;
var bar_y = y + rock_size / 2 + 30;


draw_set_color(sys.col_font);
draw_bar(bar_y, 0, bar_values[0], "BORDES");

bar_y += bar_jump_y;

draw_bar(bar_y, 1, bar_values[1], "RELLENO");

bar_y += bar_jump_y;

draw_bar(bar_y, 2, bar_values[2], "RESIDUO");

draw_set_color(c_white);

draw_sprite_ext(spr_drill, 0, drill_x, drill_y, 1, 1, drill_angle, merge_color(c_white, c_red, clamp(stress / max_stress, 0, 1)), image_alpha);

timer++;