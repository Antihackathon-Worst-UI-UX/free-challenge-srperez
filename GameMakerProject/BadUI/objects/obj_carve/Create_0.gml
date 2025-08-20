carved_points = [];
carve_size = sys.carve_size;
drill_x = sys.game_size + 100;
drill_y = sys.game_size / 2;

tip_x = 0;
tip_y = 0;
tip_size = 16;

stress = 0;

max_stress = 60;

drill_angle = 0;

drill_on = true;
timer = 0;

rock_size = sys.rock_size;

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
	borders : 0.82,
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

state = "carving";
state_timer = 0;

bar_alpha = 1;

done_btt = noone;