// Array of level backgrounds
level_sprites = [
    spr_levelSelector_lvl1,
    spr_levelSelector_lvl2,
    spr_levelSelector_lvl3,
    spr_levelSelector_lvl4,
    spr_levelSelector_lvl5,
    spr_levelSelector_lvl6
];

// Current level selected
selected_level = 1;

// Play level selector music
if (!audio_is_playing(bg_levelMusic)) {
    audio_play_sound(bg_levelMusic, 1, true); // loop
}

// Optional: stop title music
audio_stop_sound(bg_title_music);