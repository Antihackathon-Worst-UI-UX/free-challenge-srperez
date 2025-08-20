carved_points = [];
rock_surface = -1;
normal_scale = 3;
scale = normal_scale;
image_xscale = scale;
image_yscale = scale;

hover_scale = 1;

state = "idle";
state_timer = 0;

rx = x;
ry = y;

place_x = x;
place_y = y;

image_alpha = 0;
letter_rock_index = array_length(obj_game.carved_letters);
letter_index = 0;

special = false;
special_dist = 0;

souls = 6;
soul_data = [];
repeat 6 {
	array_push(soul_data, [0, 0, 0, 0]);
}