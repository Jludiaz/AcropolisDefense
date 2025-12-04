if (instance_exists(target_id)) {
    var t = instance_find(target_id, 0);
    if (t != noone) {
        var dir = point_direction(x,y,t.x,t.y);
        x += lengthdir_x(spd, dir);
        y += lengthdir_y(spd, dir);
        if (point_distance(x,y,t.x,t.y) < 8) {
            t.hp -= damage;
            instance_destroy();
        }
    } else {
        instance_destroy();
    }
} else {
    instance_destroy();
}