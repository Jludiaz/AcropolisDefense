// --- Input ---
if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down) ||
    keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
    current_level = min(level_count, current_level + 1);
}

if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up) ||
    keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
    current_level = max(1, current_level - 1);
}

// --- Update target position ---
target_x = level_x[current_level - 1];
target_y = level_y[current_level - 1];

// --- Smooth movement ---
x = lerp(x, target_x, move_speed);
y = lerp(y, target_y, move_speed);

// --- Camera centering ---
var cam = view_camera[0];
var desired_x = x - (camera_get_view_width(cam)/(2*camera_zoom));
var desired_y = y - (camera_get_view_height(cam)/(2*camera_zoom));

// Smooth camera position
camera_set_view_pos(cam,
    lerp(camera_get_view_x(cam), desired_x, 0.1),
    lerp(camera_get_view_y(cam), desired_y, 0.1)
);

// Smooth zoom
camera_zoom = lerp(camera_zoom, target_zoom, zoom_speed);
camera_set_view_size(cam,
    camera_get_view_width(cam)/camera_zoom,
    camera_get_view_height(cam)/camera_zoom
);