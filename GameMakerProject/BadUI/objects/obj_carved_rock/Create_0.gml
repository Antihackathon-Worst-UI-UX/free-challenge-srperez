carved_points = [];
rock_surface = -1;
scale = 3;
image_xscale = scale;
image_yscale = scale;

state = "idle";
state_timer = 0;

rx = x;
ry = y;

image_alpha = 0;
letter_rock_index = array_length(obj_game.carved_letters);