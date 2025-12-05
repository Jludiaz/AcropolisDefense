// Simplified test - obj_levelSelector Create Event
level_sprites = [
    spr_levelSelector_lvl1,
    spr_levelSelector_lvl2,
    spr_levelSelector_lvl3,
    spr_levelSelector_lvl4,
    spr_levelSelector_lvl5,
    spr_levelSelector_lvl6
];

selected_level = 1;
sprite_index = spr_levelSelector_lvl1; // Start with level 1

// Play music
if (!audio_is_playing(bg_levelMusic)) {
    audio_play_sound(bg_levelMusic, 1, true);
}
audio_stop_sound(bg_title_music);