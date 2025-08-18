function vec_sum(v1, v2) {
	return [v1[0] + v2[0], v1[1] + v2[1]];
}

function vec_mult(v1, scale) {
	return [v1[0] * scale, v1[1] * scale];
}

function vec_sub(v1, v2) {
	var res = vec_sum(v1, vec_mult(v2, -1));
	return [res[0], res[1]];
}

function bezier_linear(init_point, dest_point, val) {
	return vec_sum(init_point, vec_mult(vec_sub(dest_point, init_point), clamp(val, 0, 1)));
}

function bezier_quad(init_point, dest_point, bend_point, val) {
	val = clamp(val, 0, 1);
	return bezier_linear(bezier_linear(init_point, bend_point, val), bezier_linear(bend_point, dest_point, val), val);
}

function bezier_cubic(init_point, dest_point, bend_point1, bend_point2, val) {
	val = clamp(val, 0, 1);
	return vec_sum(
		vec_mult(bezier_quad(init_point, bend_point2, bend_point1, val), 1 - val),
		vec_mult(bezier_quad(bend_point1, dest_point, bend_point2, val), val)
		)
}

function tween_linear(init_val, dest_val, time) {
	var tween = bezier_linear([init_val, 0], [dest_val, 0], time);
	return tween[0];
}

function tween_ease(init_val, dest_val, time) {
	var res = bezier_cubic([0, 0], [1, 1], [0.5, 0], [0.5, 1], time);
	var tween = bezier_linear([init_val, 0], [dest_val, 0], res[1]);
	return tween[0];
}

function tween_exp(init_val, dest_val, time) {
	var res = bezier_quad([0, 0], [1, 1], [1, 1], time);
	var tween = bezier_linear([init_val, 0], [dest_val, 0], res[1]);
	return tween[0];
}


function tween_alpha(ob, alpha, time) {
	with obj_fader {
		if (ob == target) instance_destroy();
	}
	
	var f = instance_create_layer(0, 0, layer, obj_fader);
	with f {
		target = ob;
		init_alpha = ob.image_alpha;
		target_alpha = alpha;
		total_time = time;
	}
}