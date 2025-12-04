/// MOUSE GRID CALCULATION
var col = floor((mouse_x - grid_offset_x) / cell_size);
var row = floor((mouse_y - grid_offset_y) / cell_size);

/// PLACE TOWER
if (mouse_check_button_pressed(mb_left)) {
    if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
        if (map_array[row][col] == 0 && tower_grid[col][row] == -1 && global.points >= tower_cost) {
            var tower = instance_create_layer(
                grid_offset_x + col * cell_size + cell_size/2,
                grid_offset_y + row * cell_size + cell_size/2,
                "Instances",
                obj_towerParent
            );
            tower_grid[col][row] = tower.id;
            global.points -= tower_cost;
        }
    }
}

/// ENEMY SPAWN
if (enemies_remaining > 0) {
    wave_timer--;
    if (wave_timer <= 0) {
        instance_create_layer(path_start_x, path_start_y, "Instances", obj_enemyParent);
        enemies_remaining--;
        wave_timer = wave_interval;
    }
}