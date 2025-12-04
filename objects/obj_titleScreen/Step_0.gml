// Press Enter to start fade
if (keyboard_check_pressed(vk_enter) && !fade_out) {
    fade_out = true;  // start fading to black
}

// Animate "Press Enter to Start" alpha
text_alpha += text_fade_speed * fade_direction;
if (text_alpha <= 0) { text_alpha = 0; fade_direction = 1; }
if (text_alpha >= 1) { text_alpha = 1; fade_direction = -1; }

// Handle fade out
if (fade_out) {
    fade_alpha += 0.02; // speed of fade
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        room_goto(rm_levelSelector); // Go to level selector after fade
    }
}