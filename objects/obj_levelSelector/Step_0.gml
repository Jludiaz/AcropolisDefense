var sel = instance_exists(obj_selector) ? obj_selector : noone;

if (sel != noone) {
    selected_level = clamp(sel.current_level, 1, array_length(level_sprites));
    sprite_index = level_sprites[selected_level - 1];
}