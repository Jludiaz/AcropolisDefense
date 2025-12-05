/// obj_controller - Step Event
/// Handles wave spawning, tower placement, and victory detection

// ===== VICTORY CHECK =====
if (game_won) {
    // Fade in victory screen
    if (victory_alpha < 1) {
        victory_alpha += 0.02;
    }
    
    // Press ENTER to continue
    if (keyboard_check_pressed(vk_enter)) {
        room_goto(rm_levelSelector);
    }
    exit; // Don't process game logic while victory screen is showing
}

// ===== WAVE MANAGEMENT =====
if (!wave_active) {
    // Countdown to next wave
    wave_countdown--;
    
    // Check for manual wave start button click
    var ui_x = 20;
    var ui_y = 20;
    var line_height = 25;
    var btn_x = ui_x;
    var btn_y = ui_y + line_height * 3;
    var btn_w = 150;
    var btn_h = 35;
    
    // Start wave with button click OR spacebar
    if (keyboard_check_pressed(vk_space)) {
        // Spacebar always works
        wave_countdown = 0;
    }
    
    if (mouse_check_button_pressed(mb_left)) {
        if (point_in_rectangle(mouse_x, mouse_y, btn_x, btn_y, btn_x + btn_w, btn_y + btn_h)) {
            // Check we're not clicking on shop
            var shop = instance_find(obj_shopUI, 0);
            if (shop == noone || mouse_x < shop.shop_x - 20) {
                wave_countdown = 0; // Force wave to start immediately
            }
        }
    }
    
    if (wave_countdown <= 0) {
        // Check if all waves are complete - VICTORY!
        if (wave_number >= array_length(wave_configs)) {
            game_won = true;
            victory_alpha = 0;
            show_debug_message("LEVEL COMPLETE!");
            exit;
        }
        
        // Start next wave
        if (wave_number < array_length(wave_configs)) {
            wave_number++;
            wave_active = true;
            
            var wave = wave_configs[wave_number - 1];
            enemies_to_spawn = wave[0] + wave[1]; // total enemies
            enemies_spawned = 0;
            spawn_timer = 0;
            
            show_debug_message("Wave " + string(wave_number) + " started!");
        }
    }
}

// ===== ENEMY SPAWNING =====
if (wave_active && enemies_spawned < enemies_to_spawn) {
    spawn_timer--;
    if (spawn_timer <= 0) {
        // Spawn enemy at first waypoint
        if (array_length(path_waypoints) > 0) {
            var spawn_wp = path_waypoints[0];
            
            // Determine enemy type based on wave config
            var wave = wave_configs[wave_number - 1];
            var basic_count = wave[0];
            
            var enemy_type = obj_enemy_basic;
            if (enemies_spawned >= basic_count) {
                enemy_type = obj_enemy_fast;
            }
            
            var e = instance_create_layer(spawn_wp[0], spawn_wp[1], "Instances", enemy_type);
            e.waypoint_index = 0;
            
            enemies_spawned++;
            spawn_timer = spawn_interval;
        }
    }
}

// Check if wave complete (all spawned AND all destroyed)
if (wave_active) {
    if (enemies_spawned >= enemies_to_spawn && !instance_exists(obj_enemyParent)) {
        wave_active = false;
        wave_countdown = 300; // 5 seconds before next wave
        global.money += 50; // wave completion bonus
        show_debug_message("Wave " + string(wave_number) + " complete!");
        
        // Check if this was the last wave - VICTORY!
        if (wave_number >= array_length(wave_configs)) {
            game_won = true;
            victory_alpha = 0;
            show_debug_message("ALL WAVES COMPLETE - LEVEL WON!");
        }
    }
}

// ===== TOWER PLACEMENT =====
// Check if shop exists and has a tower selected
var shop = instance_find(obj_shopUI, 0);
if (shop != noone && shop.selected_tower != noone) {
    if (mouse_check_button_pressed(mb_left)) {
        var col = floor((mouse_x - grid_offset_x) / cell_size);
        var row = floor((mouse_y - grid_offset_y) / cell_size);
        
        // Check if click is within grid (not in shop area)
        if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
            if (mouse_x < shop.shop_x - 20) { // Don't place if clicking on shop
                // Find the tower cost from shop data
                var tower_cost_local = 50; // default
                for (var i = 0; i < array_length(shop.tower_types); i++) {
                    if (shop.tower_types[i].obj == shop.selected_tower) {
                        tower_cost_local = shop.tower_types[i].cost;
                        break;
                    }
                }
                
                // Check if cell is buildable (not path, not occupied, enough money)
                if (map_array[row][col] == 0 && tower_grid[col][row] == -1 && global.money >= tower_cost_local) {
                    // Create tower
                    var tx = grid_offset_x + col * cell_size + cell_size/2;
                    var ty = grid_offset_y + row * cell_size + cell_size/2;
                    var tower = instance_create_layer(tx, ty, "Instances", shop.selected_tower);
                    
                    // Register tower in grid
                    tower_grid[col][row] = tower.id;
                    global.money -= tower_cost_local;
                    
                    // Clear selection after placing
                    shop.selected_tower = noone;
                }
            }
        }
    }
}