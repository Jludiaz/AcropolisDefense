/// obj_enemyParent Step (path movement)
if (!path_started) {
    // begin path
    path_start(pth_level1, move_speed, path_action_stop, path_started);
	path_started = true;
}

// Check if reached end of path
if (path_position >= 1) {
    // damage base
    var base = instance_find(obj_base, 0);
    if (base != noone) base.hp -= 1;

    instance_destroy();
}

// Death
if (hp <= 0) {
    var ctrl = global.gameController;
    if (instance_exists(ctrl)) ctrl.money += reward;
    instance_destroy();
}