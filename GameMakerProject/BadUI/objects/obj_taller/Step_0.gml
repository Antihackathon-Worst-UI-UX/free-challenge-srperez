var rock_in_ws = false;
with obj_work_rock {
	if (state == "on-workshop") {
		rock_in_ws = true;
		break;
	}
}

var key_in_ws = false;
with obj_key {
	if (state == "on-workshop") {
		key_in_ws = true;
	}
}

workshop_ready = rock_in_ws and key_in_ws;