// Arrow sprite
sprite_index = spr_selector;

// Positions for each level on the map
level_x = [590, 590, 471, 595, 590, 814];
level_y = [574, 574, 489, 638, 574, 740];
level_count = 6;

// Start at level 1
current_level = 1;

// Initial position of the arrow
x = level_x[current_level - 1];
y = level_y[current_level - 1];

// Target for smooth movement
target_x = x;
target_y = y;
move_speed = 0.2;

// Camera zoom and movement
camera_zoom = 1.0;
target_zoom = 2.0;
zoom_speed = 0.05;

// Make sure it draws above the background
depth = -100;