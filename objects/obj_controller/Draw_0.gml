/// obj_controller - Draw Event
/// Renders grid, path, and UI

// ===== DRAW GRID =====
for (var row = 0; row < grid_rows; row++) {
    for (var col = 0; col < grid_cols; col++) {
        var xx = grid_offset_x + col * cell_size;
        var yy = grid_offset_y + row * cell_size;
        
        // Draw path cells
        if (map_array[row][col] == 1) {
            draw_set_color(c_dkgray);
            draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, false);
        } else {
            // Draw buildable cells
            draw_set_color(c_gray);
            draw_set_alpha(0.2);
            draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, false);
            draw_set_alpha(1);
        }
        
        // Draw grid lines
        draw_set_color(c_black);
        draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, true);
    }
}

// ===== HIGHLIGHT HOVERED CELL =====
var col = floor((mouse_x - grid_offset_x) / cell_size);
var row = floor((mouse_y - grid_offset_y) / cell_size);

// Check if shop exists
var shop = instance_find(obj_shopUI, 0);
var has_selection = (shop != noone && shop.selected_tower != noone);

if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
    var xx = grid_offset_x + col * cell_size;
    var yy = grid_offset_y + row * cell_size;
    
    // Only show highlight if not clicking on shop
    if (!has_selection || (has_selection && mouse_x < shop.shop_x - 20)) {
        // Determine tower cost
        var tower_cost_check = 50;
        if (has_selection) {
            for (var i = 0; i < array_length(shop.tower_types); i++) {
                if (shop.tower_types[i].obj == shop.selected_tower) {
                    tower_cost_check = shop.tower_types[i].cost;
                    break;
                }
            }
        }
        
        // Green if buildable, red if not
        if (map_array[row][col] == 0 && tower_grid[col][row] == -1 && global.money >= tower_cost_check) {
            draw_set_color(c_lime);
            draw_set_alpha(0.3);
        } else {
            draw_set_color(c_red);
            draw_set_alpha(0.3);
        }
        draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, false);
        draw_set_alpha(1);
        
        // Draw tower preview if tower is selected
        if (has_selection && map_array[row][col] == 0 && tower_grid[col][row] == -1) {
            var center_x = xx + cell_size/2;
            var center_y = yy + cell_size/2;
            
            // Draw range circle
            var tower_range = 160; // default
            for (var i = 0; i < array_length(shop.tower_types); i++) {
                if (shop.tower_types[i].obj == shop.selected_tower) {
                    tower_range = shop.tower_types[i].range;
                    break;
                }
            }
            
            if (global.money >= tower_cost_check) {
                draw_set_color(c_lime);
            } else {
                draw_set_color(c_red);
            }
            draw_set_alpha(0.2);
            draw_circle(center_x, center_y, tower_range, false);
            draw_set_alpha(0.5);
            draw_circle(center_x, center_y, tower_range, true);
            draw_set_alpha(1);
        }
    }
}

// ===== DEBUG: DRAW PATH WAYPOINTS =====
draw_set_color(c_yellow);
for (var i = 0; i < array_length(path_waypoints); i++) {
    var wp = path_waypoints[i];
    draw_circle(wp[0], wp[1], 4, false);
    
    // Draw line to next waypoint
    if (i < array_length(path_waypoints) - 1) {
        var next_wp = path_waypoints[i + 1];
        draw_line_width(wp[0], wp[1], next_wp[0], next_wp[1], 2);
    }
}

// ===== UI DISPLAY =====
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var ui_x = 20;
var ui_y = 20;
var line_height = 25;

draw_text(ui_x, ui_y, "Money: $" + string(global.money));
draw_text(ui_x, ui_y + line_height, "Wave: " + string(wave_number) + " / " + string(array_length(wave_configs)));

if (!wave_active && wave_number < array_length(wave_configs)) {
    draw_text(ui_x, ui_y + line_height * 2, "Next wave in: " + string(ceil(wave_countdown / 60)) + "s");
    
    // Draw START WAVE button
    var btn_x = ui_x;
    var btn_y = ui_y + line_height * 3;
    var btn_w = 150;
    var btn_h = 35;
    
    // Check if mouse is hovering
    var is_hovering = point_in_rectangle(mouse_x, mouse_y, btn_x, btn_y, btn_x + btn_w, btn_y + btn_h);
    
    // Draw button background
    if (is_hovering) {
        draw_set_color(c_lime);
        draw_set_alpha(0.8);
    } else {
        draw_set_color(c_green);
        draw_set_alpha(0.6);
    }
    draw_roundrect(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
    draw_set_alpha(1);
    
    // Draw button border
    draw_set_color(c_white);
    draw_roundrect(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, true);
    
    // Draw button text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(btn_x + btn_w/2, btn_y + btn_h/2, "START WAVE " + string(wave_number + 1));
    
    // Draw hint below button
    draw_set_valign(fa_top);
    draw_set_color(c_ltgray);
    draw_text(btn_x + btn_w/2, btn_y + btn_h + 5, "(Press SPACE)");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
} else if (wave_active) {
    draw_text(ui_x, ui_y + line_height * 2, "Enemies: " + string(enemies_spawned) + " / " + string(enemies_to_spawn));
    
    // Show remaining enemies in the field
    var enemies_alive = instance_number(obj_enemyParent);
    draw_text(ui_x, ui_y + line_height * 3, "Enemies Alive: " + string(enemies_alive));
}

// Base HP
if (instance_exists(obj_base)) {
    var base = instance_find(obj_base, 0);
    draw_text(ui_x, ui_y + line_height * 5, "Base HP: " + string(base.hp) + " / " + string(base.max_hp));
}

// ===== VICTORY SCREEN =====
if (game_won) {
    // Dark overlay
    draw_set_color(c_black);
    draw_set_alpha(victory_alpha * 0.7);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    
    // Victory text
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(victory_alpha);
    
    var center_x = room_width / 2;
    var center_y = room_height / 2;
    
    // Title
    draw_text_transformed(center_x, center_y - 80, "LEVEL PASSED!", 2, 2, 0);
    
    // Stats
    draw_set_color(c_white);
    draw_text(center_x, center_y, "Waves Completed: " + string(wave_number) + " / " + string(array_length(wave_configs)));
    draw_text(center_x, center_y + 30, "Money Earned: $" + string(global.money));
    if (instance_exists(obj_base)) {
        var base = instance_find(obj_base, 0);
        draw_text(center_x, center_y + 60, "Base HP Remaining: " + string(base.hp) + " / " + string(base.max_hp));
    }
    
    // Continue prompt (pulsing effect)
    var pulse = abs(sin(current_time / 500));
    draw_set_alpha(victory_alpha * pulse);
    draw_set_color(c_lime);
    draw_text(center_x, center_y + 120, "Press ENTER to Continue");
    
    // Reset draw settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}