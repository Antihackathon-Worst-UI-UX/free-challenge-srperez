switch state {
	case "waiting":
		vsp += grav;
		y += vsp;
		var yaw = dsin(sys.frame * 4 + y) * (marker_y(4) - y) / 48;
		image_angle = -yaw * 0.1;
		x = xstart + yaw;
		
		bounce_vsp = abs(vsp) * -0.25;
		if (bounce_vsp > 1) bounce_vsp = 0;
	break;
	
	case "falling":
		vsp += grav;
		y += vsp;
		image_angle ++;
	break;
}