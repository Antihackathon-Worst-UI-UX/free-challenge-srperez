var desk_scale = (1024/225) * scale;
var desk_col = sys.col_font;
switch state {
	case "waiting":
	case "waiting-clicked":
		desk_col = sys.col_bg;
		break;
}
draw_sprite_ext(spr_desk, 0, x, y, desk_scale, desk_scale, 0, desk_col, image_alpha);
draw_set_color(sys.col_bg);
draw_set_alpha(image_alpha);
var size = 1024 * scale;
var half = size / 2;
draw_rectangle(x - half, y - half, x + half, y + half, false);

var draw_field = function(half, pos_factor, label) {
	draw_set_color(sys.col_font);
	var bar_y = y + (half * pos_factor);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, bar_y - 90 * scale, label, scale, scale, 0);

	draw_set_color(sys.col_input);
	var r = 32 * scale;
	draw_roundrect_ext(x - half * 0.9, bar_y - 48 * scale, x + half * 0.9, bar_y + 48 * scale, r, r, false);
}

draw_field(half, -0.65, "Email");
draw_field(half, -0.2, "Password");
draw_set_alpha(1);
draw_set_color(sys.col_font);

if (hover_limit > 0) {
	text_render(hover_text, mouse_x + 20, mouse_y + 20, 0.15, fa_left, fa_top, 5, render_gfx.black_fill, hover_limit);
}
