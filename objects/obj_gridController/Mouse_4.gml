var col = floor((mouse_x - grid_offset_x) / cell_size);
var row = floor((mouse_y - grid_offset_y) / cell_size);

if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
    if (grid[col][row] == -1 && global.points >= plant_cost) {

        var plant = instance_create_layer(
            grid_offset_x + col * cell_size + cell_size/2,
            grid_offset_y + row * cell_size + cell_size/2,
            "Instances",
            obj_plant
        );

        grid[col][row] = plant.id;
    }
}

// Player movement click
if (mouse_check_button_pressed(mb_left)) {

    // Move player to click location
    with (obj_character) { target_x = mouse_x; }
    with (obj_character) { target_y = mouse_y; }
	
}

// Move the player to the click location
if (instance_exists(player)) {
    player.target_x = mouse_x;
    player.target_y = mouse_y;
}