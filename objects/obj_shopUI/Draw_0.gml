/// obj_shopUI - Draw GUI Event
/// Renders the shop interface

// Draw shop background
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_roundrect(shop_x, shop_y, shop_x + shop_width, shop_y + shop_height, false);
draw_set_alpha(1);

// Draw shop border
draw_set_color(c_white);
draw_roundrect(shop_x, shop_y, shop_x + shop_width, shop_y + shop_height, true);

// Draw shop title
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(shop_x + shop_width/2, shop_y + 15, "TOWER SHOP");

// Draw money display
draw_set_color(c_lime);
draw_text(shop_x + shop_width/2, shop_y + 40, "$" + string(global.money));

// Draw each tower button
for (var i = 0; i < array_length(tower_types); i++) {
    var tower_data = tower_types[i];
    var btn_x = shop_x + button_padding;
    var btn_y = shop_y + 80 + (i * (button_height + button_padding));
    var btn_w = shop_width - (button_padding * 2);
    var btn_h = button_height;
    
    var can_afford = global.money >= tower_data.cost;
    var is_selected = selected_tower == tower_data.obj;
    var is_hovered = hovered_index == i;
    
    // Button background
    if (is_selected) {
        draw_set_color(c_yellow);
        draw_set_alpha(0.5);
    } else if (is_hovered && can_afford) {
        draw_set_color(c_white);
        draw_set_alpha(0.3);
    } else if (!can_afford) {
        draw_set_color(c_red);
        draw_set_alpha(0.2);
    } else {
        draw_set_color(c_dkgray);
        draw_set_alpha(0.6);
    }
    draw_roundrect(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
    draw_set_alpha(1);
    
    // Button border
    if (is_selected) {
        draw_set_color(c_yellow);
    } else if (can_afford) {
        draw_set_color(c_white);
    } else {
        draw_set_color(c_gray);
    }
    draw_roundrect(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, true);
    
    // Tower name
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    if (can_afford) {
        draw_set_color(c_white);
    } else {
        draw_set_color(c_gray);
    }
    draw_text(btn_x + 8, btn_y + 8, tower_data.name);
    
    // Cost
    if (can_afford) {
        draw_set_color(c_lime);
    } else {
        draw_set_color(c_red);
    }
    draw_set_halign(fa_right);
    draw_text(btn_x + btn_w - 8, btn_y + 8, "$" + string(tower_data.cost));
    
    // Description
    draw_set_color(c_ltgray);
    draw_set_halign(fa_left);
    draw_text_ext(btn_x + 8, btn_y + 30, tower_data.desc, 16, btn_w - 16);
    
    // Stats
    draw_set_color(c_white);
    draw_text(btn_x + 8, btn_y + 60, "Range: " + string(tower_data.range));
    draw_text(btn_x + 8, btn_y + 75, "Damage: " + string(tower_data.damage) + " | Rate: " + tower_data.fire_rate);
}

// Draw instruction text at bottom
draw_set_color(c_ltgray);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
if (selected_tower != noone) {
    draw_text(shop_x + shop_width/2, shop_y + shop_height - 10, "Click to place\nRight-click to cancel");
} else {
    draw_text(shop_x + shop_width/2, shop_y + shop_height - 10, "Select a tower to build");
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);