carved_points = [];
carve_size = 32;
drill_x = 0;
drill_y = 0;

tip_x = 0;
tip_y = 0;
tip_size = 16;

stress = 0;

max_stress = 60;

drill_angle = 0;

drill_on = true;
timer = 0;

rock_size = 1024 / 1.5;

image_alpha = 0;

pause_drill = false;

lmouse_x = mouse_x;
lmouse_y = mouse_y;

letter = 0;

timer = 0;

acc = {
	borders : 0,
	fill : 0,
	garbage : 0
}

min_acc = {
	borders : 0.85,
	fill : 0.92,
	garbage : 0.93
}

rsize = sprite_get_width(spr_rock);
rscale = rock_size / rsize;

letSize = sprite_get_width(spr_letters);
letScale = rock_size / letSize;

border_points = [];
fill_points = [];
garbage_points = [];
border_total = 0;
fill_total = 0;
garbage_total = 0;

new_dots = [];

bar_values = [0, 1, 0];