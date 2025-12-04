// Initialize alpha for fade in/out effect
text_alpha = 1;
text_fade_speed = 0.05;
fade_direction = -1;

// Fade transition to level selector
fade_out = false;
fade_alpha = 0;  // 0 = no fade, 1 = full black

// Play title music (choose your audio file)
if (!audio_is_playing(bg_title_music)) {
    audio_play_sound(bg_title_music, 1, true); // loop = true
}