switch state {
	case "waiting":
	case "zoom-out":
		draw_set_color(sys.col_font);
		var flash_time = 30;
		draw_set_alpha(((flash_time - state_timer) / flash_time) * 0.5);
		draw_rectangle(0, 0, 2000, 2000, false);
		draw_set_alpha(1);
		break;
}