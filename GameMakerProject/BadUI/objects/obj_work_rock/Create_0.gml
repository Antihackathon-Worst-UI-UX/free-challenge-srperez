rock_sep = 32;
state = "waiting";
image_xscale = 3;
image_yscale = 3;
vsp = 0;
bounce_vsp = 0;

floor_y = sys.game_size;
grav = 0.2;

visual_scale = 1;

mouse_xoff = 0;
mouse_yoff = 0;

order_floors = function() {
	var rocks = [];
	with obj_work_rock {
		if (state == "waiting") array_push(rocks, id);
	}
	
	array_sort(rocks, function(r1, r2) {if (r1.y > r2.y) return -1; return 1});
	
	for (var i = 0; i < array_length(rocks); i++) {
		rocks[i].floor_y = marker_y(4) - rock_sep * i;
	}
}

order_floors();