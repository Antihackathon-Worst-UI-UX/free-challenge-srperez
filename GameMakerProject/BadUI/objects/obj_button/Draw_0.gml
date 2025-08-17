timer++;
var sc = 1 + 0.3 * tween_ease(0, 1, (select_timer / select_max));
image_xscale = (1 + dcos(timer * 4) * 0.05) * sc;
image_yscale = (1 + dsin(timer * 5) * 0.05) * sc;

draw_sprite_ext(spr_arrow, 0, x, y, image_xscale, image_yscale, (2 - arrow_dir * 2) * 180 + dcos(timer * 2) * 9, sys.col_font, image_alpha);
draw_set_halign(fa_left);
if (arrow_dir == -1) draw_set_halign(fa_right);

draw_set_alpha(image_alpha);
draw_set_color(sys.col_font);
draw_set_font(sys.fnt_carved)
draw_text_transformed(x + sprite_width * 0.6 * arrow_dir, y + dsin(timer * 2) * 15, string_upper(text), 0.2, 0.2, 0);
draw_set_alpha(1);
draw_set_font(fnt_roboto);
