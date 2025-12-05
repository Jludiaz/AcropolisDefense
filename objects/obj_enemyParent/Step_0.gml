/// obj_enemyParent - Step Event
/// Waypoint-based movement system

// Initialize waypoint tracking
if (!variable_instance_exists(id, "waypoint_index")) {
    waypoint_index = 0;
}

// Get controller
var ctrl = instance_find(obj_controller, 0);
if (ctrl == noone) {
    instance_destroy();
    exit;
}

// Check if we have waypoints
if (array_length(ctrl.path_waypoints) == 0) {
    instance_destroy();
    exit;
}

// Get current target waypoint
if (waypoint_index >= array_length(ctrl.path_waypoints)) {
    // Reached end of path - damage base
    var base = instance_find(obj_base, 0);
    if (base != noone) {
        base.hp -= 1;
        if (base.hp <= 0) {
            room_restart();
        }
    }
    instance_destroy();
    exit;
}

var target_wp = ctrl.path_waypoints[waypoint_index];
var target_x = target_wp[0];
var target_y = target_wp[1];

// Move towards current waypoint
var dist = point_distance(x, y, target_x, target_y);

if (dist > move_speed) {
    // Move towards waypoint
    var dir = point_direction(x, y, target_x, target_y);
    x += lengthdir_x(move_speed, dir);
    y += lengthdir_y(move_speed, dir);
    
    // Face movement direction
    if (lengthdir_x(move_speed, dir) != 0) {
        image_xscale = sign(lengthdir_x(move_speed, dir));
    }
} else {
    // Reached waypoint, move to next
    x = target_x;
    y = target_y;
    waypoint_index++;
}

// Death check
if (hp <= 0) {
    global.money += reward;
    instance_destroy();
}