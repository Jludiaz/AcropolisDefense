/// obj_tower_rapid - Step Event
/// Fast firing tower

fire_timer--;
if (fire_timer <= 0) {
    // find nearest enemy
    var target = instance_nearest(x, y, obj_enemyParent);
    if (target != noone) {
        if (point_distance(x,y,target.x,target.y) <= range) {
            // spawn bullet
            var b = instance_create_layer(x, y, "Instances", obj_projectile);
            b.target_id = target.id;
            b.damage = damage;
            fire_timer = fire_rate;
        }
    }
}