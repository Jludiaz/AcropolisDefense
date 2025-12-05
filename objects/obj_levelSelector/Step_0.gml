// obj_levelSelector - Step Event (FIXED)

// Find the selector instance
var sel = instance_find(obj_selector, 0);

if (sel != noone) {
    // Get current level from selector
    selected_level = clamp(sel.current_level, 1, array_length(level_sprites));
    
    // Update sprite to match selected level
    sprite_index = level_sprites[selected_level - 1];
}