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