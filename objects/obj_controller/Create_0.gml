/// obj_controller - Create Event
/// This handles grid setup, path generation, and game state

// ===== GRID CONFIGURATION =====
grid_cols = 15;
grid_rows = 10;

// Calculate cell size to fit the room
cell_size = min(room_width / grid_cols, room_height / grid_rows);
grid_offset_x = (room_width - grid_cols * cell_size) / 2;
grid_offset_y = (room_height - grid_rows * cell_size) / 2;

// ===== TOWER GRID STORAGE =====
// Stores tower IDs (-1 = empty cell)
tower_grid = array_create(grid_cols);
for (var i = 0; i < grid_cols; i++) {
    tower_grid[i] = array_create(grid_rows, -1);
}

// ===== LOAD LEVEL CONFIGURATION =====
// Set current_level in room creation code or as a global variable
if (!variable_global_exists("current_level")) {
    global.current_level = 1;
}

var level_data = scr_get_level_config(global.current_level);
map_array = level_data.map;
wave_configs = level_data.waves;
global.money = level_data.starting_money;

// ===== GENERATE PATH WAYPOINTS =====
// Convert grid cells to world coordinates for enemies to follow
path_waypoints = [];

// Find the starting cell (leftmost path cell in top row, or first encountered)
var start_col = -1;
var start_row = -1;

// Look for starting cell (usually leftmost in first rows)
for (var row = 0; row < grid_rows && start_col == -1; row++) {
    for (var col = 0; col < grid_cols; col++) {
        if (map_array[row][col] == 1) {
            start_col = col;
            start_row = row;
            break;
        }
    }
}

// Trace the path by following connected cells
if (start_col != -1) {
    var path_cells = [];
    var current_col = start_col;
    var current_row = start_row;
    var prev_col = -1;
    var prev_row = -1;
    
    // Follow the path until we can't find a next cell
    var max_iterations = grid_cols * grid_rows; // Safety limit
    var iterations = 0;
    
    while (iterations < max_iterations) {
        // Add current cell to path
        array_push(path_cells, [current_col, current_row]);
        
        // Look for next connected path cell (check 4 directions)
        var found_next = false;
        var directions = [
            [1, 0],   // right
            [0, 1],   // down
            [-1, 0],  // left
            [0, -1]   // up
        ];
        
        for (var d = 0; d < array_length(directions); d++) {
            var next_col = current_col + directions[d][0];
            var next_row = current_row + directions[d][1];
            
            // Check if valid cell and is path and not the cell we came from
            if (next_col >= 0 && next_col < grid_cols && 
                next_row >= 0 && next_row < grid_rows &&
                map_array[next_row][next_col] == 1 &&
                !(next_col == prev_col && next_row == prev_row)) {
                
                // Move to next cell
                prev_col = current_col;
                prev_row = current_row;
                current_col = next_col;
                current_row = next_row;
                found_next = true;
                break;
            }
        }
        
        if (!found_next) {
            break; // Reached end of path
        }
        
        iterations++;
    }
    
    // Generate waypoints at direction changes
    if (array_length(path_cells) > 0) {
        // Add first cell as starting waypoint
        var first_cell = path_cells[0];
        var wx = grid_offset_x + first_cell[0] * cell_size + cell_size/2;
        var wy = grid_offset_y + first_cell[1] * cell_size + cell_size/2;
        array_push(path_waypoints, [wx, wy]);
        
        // Check each cell for direction changes
        for (var i = 1; i < array_length(path_cells) - 1; i++) {
            var prev_cell = path_cells[i - 1];
            var curr_cell = path_cells[i];
            var next_cell = path_cells[i + 1];
            
            // Calculate direction vectors
            var dir_in_x = curr_cell[0] - prev_cell[0];
            var dir_in_y = curr_cell[1] - prev_cell[1];
            var dir_out_x = next_cell[0] - curr_cell[0];
            var dir_out_y = next_cell[1] - curr_cell[1];
            
            // If direction changed, add waypoint
            if (dir_in_x != dir_out_x || dir_in_y != dir_out_y) {
                var wx = grid_offset_x + curr_cell[0] * cell_size + cell_size/2;
                var wy = grid_offset_y + curr_cell[1] * cell_size + cell_size/2;
                array_push(path_waypoints, [wx, wy]);
            }
        }
        
        // Add last cell as ending waypoint
        var last_cell = path_cells[array_length(path_cells) - 1];
        var wx = grid_offset_x + last_cell[0] * cell_size + cell_size/2;
        var wy = grid_offset_y + last_cell[1] * cell_size + cell_size/2;
        array_push(path_waypoints, [wx, wy]);
    }
}

// ===== GAME STATE =====
global.money = level_data.starting_money;
tower_cost = 50;

// Wave system
wave_number = 0;
wave_active = false;
wave_countdown = 180; // 3 seconds before first wave
enemies_to_spawn = 0;
enemies_spawned = 0;
spawn_timer = 0;
spawn_interval = 60; // spawn every 1 second

// Victory state
game_won = false;
victory_alpha = 0;

// wave_configs loaded from level data above

// ===== BASE SETUP =====
base_hp = 20;
base_max_hp = 20;

// Place base at end of path
if (array_length(path_waypoints) > 0) {
    var last_wp = path_waypoints[array_length(path_waypoints) - 1];
    instance_create_layer(last_wp[0], last_wp[1], "Instances", obj_base);
}