// -----------------------------------
// 1. Clicking the UI shop button
// -----------------------------------
if (mouse_check_button_pressed(mb_left)) {

    // Click button
    if (position_meeting(mouse_x, mouse_y, obj_buttonBasicTower)) {
        selected_tower = obj_tower_basic;
        show_debug_message("Tower Selected");
        exit;
    }

    // Place tower anywhere else
    if (selected_tower != noone && !position_meeting(mouse_x, mouse_y, obj_buttonBasicTower)) {
        instance_create_layer(mouse_x, mouse_y, "Instances", selected_tower);
        show_debug_message("Tower Placed");
        selected_tower = noone;
    }
}