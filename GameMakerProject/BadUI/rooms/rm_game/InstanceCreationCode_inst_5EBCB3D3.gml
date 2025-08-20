alpha_fun = function() {
	with obj_login_screen {
		if (state == "game") {
			return image_alpha;
		}
		if (state == "try-trans") return -1000;
	}
	return 0;
}