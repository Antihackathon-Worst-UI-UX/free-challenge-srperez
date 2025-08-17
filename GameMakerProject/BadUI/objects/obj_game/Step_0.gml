var add_button = function(_x, _y, text, dir, action) {
	var btt = instance_create_layer(_x, _y, layer, obj_button);
	btt.text = text;
	btt.arrow_dir = dir;
	btt.action = action;
	return btt;
}
switch state {
	case "desk-init":
		add_button(100, 100, "Estudio", 1, function() {
			state = "studio-init";
			instance_create_layer(x, y, layer, obj_carve);
		})
		state = "desk";
	break;
}