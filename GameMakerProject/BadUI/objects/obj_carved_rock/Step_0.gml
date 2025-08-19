image_xscale = scale;
image_yscale = scale;

x = rx;
y = ry;

var rock_sep = 128;
var table_x = marker_x(3) + rock_sep * letter_rock_index;
var table_y = marker_y(3);

var wave_move = function() {
	y = ry + dsin(sys.frame * 3 + letter_rock_index * 25) * 4 * scale;	
}

var lstate = state;

var alpha = -1;

switch state {
	case "idle":
		wave_move();
		
		alpha = obj_taller.image_alpha;
		
		if (state_timer >= 60) {
			state = "float-trans";
			break;
		}
		
	break;
	
	case "float-trans":
		var duration = 120;
		wave_move();
		rx = tween_ease(xstart, table_x, state_timer / duration);
		ry = tween_ease(ystart, table_y, state_timer / duration);
		
		alpha = max(obj_taller.image_alpha, obj_login_screen.image_alpha);
		
		if (state_timer >= duration) {
			state = "waiting";
			break;
		}
		
	break;
	
	case "waiting":
		wave_move();
		rx += (table_x - rx) / 6;
		ry += (table_y - ry) / 6;
	break;
}

if (alpha != -1) image_alpha = alpha;
else image_alpha = obj_login_screen.image_alpha;

state_timer++;
if (lstate != state) state_timer = 0;