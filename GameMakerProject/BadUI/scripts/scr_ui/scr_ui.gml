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

function text_render(text, x, y, scale, halign = fa_center, valign = fa_middle, wave = 0, limit = -1) {
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
			draw_sprite_ext(spr_letters, q[j], lx, ly, scale, scale, 0, draw_get_color(), draw_get_alpha());
			
			charInd++;
		}
	}
}
