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

var draw_field = function(half, pos_factor, label, ind) {
	draw_set_color(sys.col_font);
	var bar_y = y + (half * pos_factor);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, bar_y - 90 * scale, label, scale, scale, 0);

	draw_set_color(sys.col_input);
	var r = 32 * scale;
	draw_roundrect_ext(x - half * 0.9, bar_y - 48 * scale, x + half * 0.9, bar_y + 48 * scale, r, r, false);
	
	field_positions[ind] = bar_y;
}

var draw_login = function(half, yy, label) {
	
	var ly = y + yy * scale;
	
	
	draw_set_color(merge_color(sys.col_font, c_white, login_hover));
	var r = 32 * scale;
	draw_roundrect_ext(x - half * 0.4, ly - 48 * scale, x + half * 0.4, ly + 48 * scale, r, r, false);
	
	draw_set_color(sys.col_bg);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, ly, label, scale, scale, 0);
	draw_set_color($2200AA);
	draw_text_transformed(x, ly - 90 * scale, error_message, scale * 0.7, scale * 0.7, 0);
}

if (!logged_in) {
	draw_field(half, -0.65, "Username", 0);
	draw_field(half, -0.2, "Password", 1);
	draw_login(half, login_y, "Log-in");
}
else {
	draw_set_color(sys.col_font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var txt = "Welcome " + obj_game.username + "!\nYou've succesfully logged in.\n \nAlthough, I didn't get to\nsee your password.\n\nso maybe I'll forget you";
	draw_login(half, logout_y, "Log-out");
	draw_login(half, forget_y, "Forget me");
	
	draw_set_color(sys.col_font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, y - 200 * scale, txt, scale, scale, 0);
}

draw_set_color(sys.col_font);
if (hover_limit > 0) {
	text_render(hover_text, mouse_x + 20, mouse_y + 20, 0.15, fa_left, fa_top, 5, render_gfx.black_fill, hover_limit);
}

draw_set_alpha(1);



