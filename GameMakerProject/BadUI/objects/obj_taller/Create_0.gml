x = -room_width + sprite_xoffset;
y = sprite_yoffset;
image_alpha = 0;

for (var i = 0; i < 14; i++) {
	var rock = instance_create_layer(-200, -1000 + i * 32, "interact", obj_work_rock);
	rock.floor_y = room_height / 2;
}