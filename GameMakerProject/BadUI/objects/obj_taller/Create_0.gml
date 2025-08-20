x = -room_width + sprite_xoffset;
y = sprite_yoffset;
image_alpha = 0;

image_blend = sys.col_font;

workhsop_ready = false;

for (var i = 0; i < 14; i++) {
	var rock = instance_create_layer(marker_x(4), i * 32, "rocks", obj_work_rock);
}