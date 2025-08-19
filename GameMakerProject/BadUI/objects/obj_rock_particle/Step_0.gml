if frame == 0 {
	angle += random_range(-7, 7);

	vsp = -dsin(angle) * spd;
	hsp = dcos(angle) * spd;

	image_xscale *= random_range(0.5, 1.5);
	image_yscale *= random_range(0.5, 1.5);
	
	life *= random_range(1, 2);
}

x += hsp;
y += vsp;
image_angle -= hsp;

vsp += grav;

frame++;
if (frame > life) image_alpha -= 0.05;
if (image_alpha <= 0) instance_destroy();