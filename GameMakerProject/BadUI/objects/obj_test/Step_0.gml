/*
x += hspd;
y += vspd;

if (clamp(x, 0, room_width) != x) {
	hspd = -sign(hspd) * spd_factor + random_range(-5, 2);
	x = clamp(x, 0, room_width);
}
if (clamp(y, 0, room_height) != y) {
	vspd = -sign(vspd) * spd_factor + random_range(-5, 2);
	y = clamp(y, 0, room_height);
}
*/
x = mouse_x;
y = mouse_y;