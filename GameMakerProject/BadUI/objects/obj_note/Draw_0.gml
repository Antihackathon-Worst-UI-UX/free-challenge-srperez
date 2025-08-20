draw_sprite_ext(spr_note, 0, x, y, image_xscale * hover_scale, image_yscale * hover_scale, image_angle + dsin(sys.frame * 1.5) * 15, sys.col_font, image_alpha);
draw_sprite_ext(spr_note, 1, x, y, image_xscale, image_yscale, image_angle, sys.col_font, image_alpha);

var cam_x = camera_get_view_x(view_camera[0]);
draw_sprite_ext(spr_note, 0, cam_x + sys.game_size / 2, 30, 6, 6, 0, sys.col_font, content_alpha);
draw_sprite_ext(spr_note_content, content, cam_x + sys.game_size / 2, sys.game_size / 2, 1, 1, 0, sys.col_font, content_alpha);