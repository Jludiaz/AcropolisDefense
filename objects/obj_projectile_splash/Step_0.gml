if (instance_exists(target_id)) {
    var dir = point_direction(x, y, target_id.x, target_id.y);
    x += lengthdir_x(spd, dir);
    y += lengthdir_y(spd, dir);
    
    // Check if reached target
    if (point_distance(x, y, target_id.x, target_id.y) < 12) {
        // Deal splash damage to all enemies in radius
        with (obj_enemyParent) {
            if (point_distance(x, y, other.x, other.y) <= other.splash_radius) {
                hp -= other.damage;
            }
        }
        
        // Visual effect (optional - you can add a sprite here)
        // instance_create_layer(x, y, "Instances", obj_explosion_effect);
        
        instance_destroy();
    }
} else {
    instance_destroy();
}
