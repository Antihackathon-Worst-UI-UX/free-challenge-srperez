function index_to_letter(ind) {
	var let = chr(ord("A") + floor(ind / 2));
			
	switch ind {
		case 52: let = "*" break;
		case 54: let = "." break;
		case 56: let = "," break;
		case 58: let = "!" break;
		case 60: let = "?" break;
		case -1: let = " " break;
	}
	
	return let;
}
function text_render_cache(text) {
	var letter_queue = [[]];
	var line = 0;
	
	for (var i = 0; i < string_length(text); i++) {
		var char = string_char_at(text, i + 1);
		if (char == "\n") {
			line++;
			array_push(letter_queue, []);
		}
		else {
			var q = letter_queue[line];
			var let = (ord(char) - ord("A")) * 2;
			
			switch char {
				case "*": let = 52 break;
				case ".": let = 54 break;
				case ",": let = 56 break;
				case "!": let = 58 break;
				case "?": let = 60 break;
				case " ": let = -1 break;
			}
			
			array_push(q, let);
		}
	}
		
	sys.text_renders[$ text] = letter_queue;
}

function text_render_access(text) {
	if (!struct_exists(sys.text_renders, text)) {
		text_render_cache(text);
	}
	
	return sys.text_renders[$ text];
}

enum render_gfx {
	none,
	black_border,
	black_fill,
	negative
}

function text_render(text, x, y, scale, halign = fa_center, valign = fa_middle, wave = 0, gfx = render_gfx.none, limit = -1) {
	var letter_queue = text_render_access(text);
	var lines = array_length(letter_queue);
	var letSize = sprite_get_width(spr_letters);
	
	var pivot_y = letSize * 0.5;
	switch valign {
		case fa_middle:
			pivot_y = (lines - 1) * letSize * -0.5;
		break;
			
		case fa_bottom:
			pivot_y -= (lines * letSize);
		break;
	}
	
	var charInd = 0;
	for (var i = 0; i < lines; i++) {
		var q = letter_queue[i];
		var chars = array_length(q);
		
		var pivot_x = letSize * 0.5;
		switch halign {
			case fa_center:
				pivot_x = (chars - 1) * letSize * -0.5
			break;
			
			case fa_right:
				pivot_x -= (chars * letSize);
			break;
		}
		
		for (var j = 0; j < chars; j++) {
			if (limit > -1 and charInd > limit) return;
			
			var ang = sys.frame * 4 + charInd * 10;
			var dist = wave;
			
			var xWave = dcos(ang) * dist;
			var yWave = -dsin(ang) * dist;
			
			var lx = x + (pivot_x + j * letSize) * scale + xWave;
			var ly = y + (pivot_y + i * letSize) * scale + yWave;
			
			var bcolor = draw_get_color();
			var balpha = 1;
			
			var fcolor = draw_get_color();
			var falpha = 0;
			
			var ocolor = draw_get_color();
			var oalpha = 0;
			
			switch gfx {
				case render_gfx.black_fill:
					falpha = 1;
					fcolor = c_black;
				break;
				
				case render_gfx.black_border:
					bcolor = c_black;
					falpha = 1;
				break;
				
				case render_gfx.negative:
					bcolor = c_black;
					fcolor = c_black;
					falpha = 1;
					oalpha = 1;
				break;
			}
			
			
			// Draw outside
			var prev_col = draw_get_color();
			var prev_alpha = draw_get_alpha();
			
			draw_set_color(ocolor);
			draw_set_alpha(oalpha * prev_alpha);
			
			draw_rectangle(
				lx - letSize * scale * 0.5, 
				ly - letSize * scale * 0.5,
				lx + letSize * scale * 0.5,
				ly + letSize * scale * 0.5,
				false
				)
				
			draw_set_color(prev_col);
			draw_set_alpha(prev_alpha);
			
			// Draw fill
			draw_sprite_ext(spr_letters, q[j] + 1, lx, ly, scale, scale, 0, fcolor, draw_get_alpha() * falpha);
			
			// Draw outline
			draw_sprite_ext(spr_letters, q[j], lx, ly, scale, scale, 0, bcolor, draw_get_alpha() * balpha);
			
			charInd++;
		}
	}
}

function rock_break(x, y, scale = 1) {
	var off = random_range(0, 360);
	for (var i = 0; i < 3; i ++) {
		var ang = off + i * (360/3);
		var dist = 32;
		var p = instance_create_layer(x + dcos(ang) * dist, y - dsin(ang) * dist, "particles", obj_rock_particle);
		p.angle = ang;
		p.image_xscale = scale;
		p.image_yscale = scale;
	}
}

function add_button(_x, _y, text, dir, action) {
	var btt = instance_create_layer(_x, _y, "buttons", obj_button);
	btt.text = text;
	btt.arrow_dir = dir;
	btt.action = action;
	return btt;
}