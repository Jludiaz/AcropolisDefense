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
var last_col = -1;
var last_row = -1;

for (var row = 0; row < grid_rows; row++) {
    for (var col = 0; col < grid_cols; col++) {
        if (map_array[row][col] == 1) {
            // Check if this is a direction change
            if (last_col != -1) {
                if (col != last_col && row != last_row) {
                    // Direction changed, add waypoint
                    var wx = grid_offset_x + last_col * cell_size + cell_size/2;
                    var wy = grid_offset_y + last_row * cell_size + cell_size/2;
                    array_push(path_waypoints, [wx, wy]);
                }
            } else {
                // First path cell - this is spawn point
                var wx = grid_offset_x + col * cell_size + cell_size/2;
                var wy = grid_offset_y + row * cell_size + cell_size/2;
                array_push(path_waypoints, [wx, wy]);
            }
            last_col = col;
            last_row = row;
        }
    }
}

// Add final waypoint (end of path)
if (last_col != -1) {
    var wx = grid_offset_x + last_col * cell_size + cell_size/2;
    var wy = grid_offset_y + last_row * cell_size + cell_size/2;
    array_push(path_waypoints, [wx, wy]);
}

// ===== GAME STATE =====
global.money = 100;
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