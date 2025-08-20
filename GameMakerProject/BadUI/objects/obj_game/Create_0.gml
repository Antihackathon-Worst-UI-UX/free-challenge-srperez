state = "desk-init";
cam_x = 0;
cam_prev_x = 0;
cam_target_x = 0;

cam_y = 0;
cam_prev_y = 0;
cam_target_y = 0;

state_timer = 0;
cam_size = camera_get_view_width(view_camera[0]);
cam_prev_size = cam_size;
cam_target_size = cam_size;

carved_letters = [];

btt_change = noone;

username = "";
password = false;

save_letters = function() {
	var f = file_text_open_write("rocks.txt")
	var letAmmo = array_length(carved_letters);
	
	file_text_write_string(f, string(letAmmo));
	file_text_writeln(f);
	
	for (var i = 0; i < array_length(carved_letters); i++)
	{
		var let = carved_letters[i];
		var dotAmmo = array_length(let.carved_points);
		
		file_text_write_string(f, string(let.letter_index));
		file_text_writeln(f)
		file_text_write_string(f, string(dotAmmo));
		file_text_writeln(f)
		
		for (var j = 0; j < dotAmmo; j++) {
			var dot = let.carved_points[j];
			file_text_write_string(f, string(dot[0]));
			file_text_writeln(f);
			file_text_write_string(f, string(dot[1]));
			file_text_writeln(f);
			
		}
		file_text_writeln(f);
	}
	
	file_text_close(f);
}

//

load_letters = function() {
	var f = file_text_open_read("rocks.txt");
	if (f == -1) return;
	
	instance_destroy(obj_carved_rock);
	carved_letters = [];
	
	var letAmmo = real(file_text_read_string(f));
	
	file_text_readln(f);
	
	for (var i = 0; i < letAmmo; i++)
	{
		var let = instance_create_layer(sys.game_size / 2, -48, "carved_letters", obj_carved_rock);
		let.letter_index = real(file_text_read_string(f));
		file_text_readln(f);
		
		var dotAmmo = real(file_text_read_string(f));
		file_text_readln(f);
		
		for (var j = 0; j < dotAmmo; j++) {
			var dot = [0, 0];
			dot[0] = real(file_text_read_string(f));
			file_text_readln(f);
			dot[1] = real(file_text_read_string(f));
			file_text_readln(f);
			array_push(let.carved_points, dot);
		}
		
		let.state = "float-trans";
		array_push(carved_letters, let);
		
		file_text_readln(f);
	}
	
	file_text_close(f);
}

load_letters();