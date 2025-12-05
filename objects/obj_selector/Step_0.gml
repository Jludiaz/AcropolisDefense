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

// ----- ENTER TO LOAD LEVEL -----
if (keyboard_check_pressed(vk_enter)) {

    switch (current_level) {
        case 1:
            room_goto(rm_level1);
            break;
        case 2:
            room_goto(rm_level2);
            break;
        case 3:
            room_goto(rm_level3);
            break;
        case 4:
            room_goto(rm_level4);
            break;
        case 5:
            room_goto(rm_level5);
            break;
        case 6:
            room_goto(rm_level6);
            break;
    }
}