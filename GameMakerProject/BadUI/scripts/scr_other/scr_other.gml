function calc_username() {
	var letters = [];
	with obj_carved_rock {
		if (!special and state == "placed") array_push(letters, id);
	}
	
	array_sort(letters, function(l1, l2) {if (l1.x < l2.x) return -1; return 1;})
	
	obj_game.username = "";
	for (var i = 0; i < array_length(letters); i++) {
		obj_game.username += index_to_letter(letters[i].letter_index);
	}
}