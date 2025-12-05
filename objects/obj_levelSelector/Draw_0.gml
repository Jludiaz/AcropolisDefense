// obj_levelSelector - Draw Event (DEBUG VERSION)

// Draw the background sprite
draw_sprite(sprite_index, 0, 0, 0);

// DEBUG: Show what's happening
/*
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var debug_y = 20;
draw_text(20, debug_y, "Current Level: " + string(selected_level));
debug_y += 30;
draw_text(20, debug_y, "Sprite Index: " + string(sprite_index));
debug_y += 30;
draw_text(20, debug_y, "Sprite Name: " + (sprite_exists(sprite_index) ? sprite_get_name(sprite_index) : "INVALID"));
debug_y += 30;
draw_text(20, debug_y, "Array Length: " + string(array_length(level_sprites)));

// Show all sprites in array
debug_y += 40;
draw_text(20, debug_y, "Sprites in array:");
for (var i = 0; i < array_length(level_sprites); i++) {
    debug_y += 25;
    var spr = level_sprites[i];
    var exists_text = sprite_exists(spr) ? "EXISTS" : "MISSING";
    draw_text(20, debug_y, string(i+1) + ": " + sprite_get_name(spr) + " - " + exists_text);
}
*/