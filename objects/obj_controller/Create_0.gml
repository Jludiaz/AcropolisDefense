/// GRID CONFIGURATION
grid_cols = 10;
grid_rows = 8;

// Tile size fallback
cell_size = 64;
grid_offset_x = 0;
grid_offset_y = 0;

// Player currency for towers
global.points = 10;
tower_cost = 5; // cost to place a tower

/// MAP ARRAY (0 = empty, 1 = path)
map_array = [
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0]
];

// Level background (replace with your sprite)
level_background = spr_rmlvl1;

/// TOWER GRID STORAGE (-1 = empty)
tower_grid = array_create(grid_cols);
for (var i = 0; i < grid_cols; i++) {
    tower_grid[i] = array_create(grid_rows, -1);
}

/// DYNAMIC CELL SIZE
cell_size = min(room_width / grid_cols, room_height / grid_rows) * 0.9;
grid_offset_x = (room_width - grid_cols * cell_size) / 2;
grid_offset_y = (room_height - grid_rows * cell_size) / 2;

/// PATH START (first tile = enemy spawn)
path_start_x = undefined;
path_start_y = undefined;

for (var i = 0; i < grid_rows; i++) {
    for (var j = 0; j < grid_cols; j++) {
        if (map_array[i][j] == 1) {
            path_start_x = grid_offset_x + j * cell_size + cell_size/2;
            path_start_y = grid_offset_y + i * cell_size + cell_size/2;
            break;
        }
    }
    if (path_start_x != undefined) break;
}

// Fallback
if (path_start_x == undefined) {
    path_start_x = cell_size/2;
    path_start_y = cell_size/2;
}

/// ENEMY WAVE CONFIGURATION
current_wave = 1;
wave_timer = 0;
wave_interval = 180;  // spawn every 3 seconds
enemies_remaining = 5;

// Optional: multiple waves
waves = [5, 8, 12];