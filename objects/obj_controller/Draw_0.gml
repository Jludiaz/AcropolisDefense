var col = floor((mouse_x - grid_offset_x) / cell_size);
var row = floor((mouse_y - grid_offset_y) / cell_size);

/// DRAW BACKGROUND
draw_sprite(level_background, 0, 0, 0);

/// DRAW GRID TILES
for (var i = 0; i < grid_cols; i++) {
    for (var j = 0; j < grid_rows; j++) {
        var xx = grid_offset_x + i * cell_size;
        var yy = grid_offset_y + j * cell_size;

        // Draw path
        if (map_array[j][i] == 1) {
            draw_set_color(c_gray);
            draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, true);
        }

        // Draw grid border
        draw_set_color(c_black);
        draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, false);
    }
}

/// HOVER HIGHLIGHT
if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
    draw_set_color(c_yellow);
    draw_rectangle(
        grid_offset_x + col * cell_size,
        grid_offset_y + row * cell_size,
        grid_offset_x + (col+1) * cell_size,
        grid_offset_y + (row+1) * cell_size,
        false
    );
}

/// UI
draw_set_color(c_white);
draw_text(10,10,"Coins: " + string(global.points));