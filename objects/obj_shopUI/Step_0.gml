// In obj_shopUI Step Event:
if (keyboard_check_pressed(ord("1"))) selected_tower = obj_tower_basic;
if (keyboard_check_pressed(ord("2"))) selected_tower = obj_tower_rapid;
if (keyboard_check_pressed(ord("3"))) selected_tower = obj_tower_sniper;
if (keyboard_check_pressed(vk_escape)) selected_tower = noone;