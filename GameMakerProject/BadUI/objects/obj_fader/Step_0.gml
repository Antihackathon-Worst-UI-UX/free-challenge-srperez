if (!instance_exists(target)) {
	instance_destroy();
	exit;
}

with target {
	image_alpha = tween_ease(other.init_alpha, other.target_alpha, other.timer / other.total_time);
}
timer++;
if (timer > total_time) {
	instance_destroy();
}