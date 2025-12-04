// -------------------------
// CALCULATE GRID POSITION
// -------------------------
var col = floor((mouse_x - obj_controller.grid_offset_x) / obj_controller.cell_size);
var row = floor((mouse_y - obj_controller.grid_offset_y) / obj_controller.cell_size);

// -------------------------
// PLACE TOWER
// -------------------------
if (mouse_check_button_pressed(mb_left)) {
    if (col >= 0 && col < obj_controller.grid_cols && row >= 0 && row < obj_controller.grid_rows) {
        if (obj_controller.map_array[col][row] == 0 && obj_controller.tower_grid[col][row] == -1) {
            if (global.points >= tower_cost) {
                var tower = instance_create_layer(
                    obj_controller.grid_offset_x + col * obj_controller.cell_size + obj_controller.cell_size/2,
                    obj_controller.grid_offset_y + row * obj_controller.cell_size + obj_controller.cell_size/2,
                    "Instances",
                    obj_towerParent
                );
                
                // register tower
                obj_controller.tower_grid[col][row] = tower.id;

                // deduct cost
                global.points -= tower_cost;
            }
        }
    }
}

// -------------------------
// GRID HOVER HIGHLIGHT
// -------------------------
if (col >= 0 && col < obj_controller.grid_cols && row >= 0 && row < obj_controller.grid_rows) {
    draw_set_color(c_yellow);
    draw_rectangle(
        obj_controller.grid_offset_x + col * obj_controller.cell_size,
        obj_controller.grid_offset_y + row * obj_controller.cell_size,
        obj_controller.grid_offset_x + (col+1) * obj_controller.cell_size,
        obj_controller.grid_offset_y + (row+1) * obj_controller.cell_size,
        false
    );
}