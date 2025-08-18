timer++;
var sc = 1 + 0.3 * tween_ease(0, 1, (select_timer / select_max));
image_xscale = (1 + dcos(timer * 4) * 0.05) * sc;
image_yscale = (1 + dsin(timer * 5) * 0.05) * sc;

var base_ang = 0;
if (arrow_dir == -1) {
	base_ang = 180;
}

draw_sprite_ext(spr_arrow, 0, x, y, image_xscale, image_yscale, base_ang + dcos(timer * 2) * 9, sys.col_font, image_alpha);

var halign = fa_left;
if (arrow_dir == -1) halign = fa_right;

draw_set_alpha(image_alpha);
draw_set_color(sys.col_font);
text_render(string_upper(text), x + sprite_width * 0.6 * arrow_dir, y, 0.2, halign, fa_middle, 3);
draw_set_alpha(1);
