function marker_data(mark){
	
	
	var ob = asset_get_index("obj_marker" + string(mark));
	if (instance_exists(ob)) {
		return [ob.x, ob.y, ob.sprite_width, ob.sprite_height];
	}
	return [0, 0, 100, 100];
}

function marker_x(mark) {
	var res = marker_data(mark);
	return res[0];
}

function marker_y(mark) {
	var res = marker_data(mark);
	return res[1];
}

function marker_left(mark) {
	var res = marker_data(mark);
	return res[0] - res[2] / 2;
}

function marker_top(mark) {
	var res = marker_data(mark);
	return res[1] - res[3] / 2;
}

function marker_width(mark) {
	var res = marker_data(mark);
	return res[2];
}

function marker_height(mark) {
	var res = marker_data(mark);
	return res[3];
}