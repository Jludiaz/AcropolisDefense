rmtimer++;

// Spawn an enemy when timer reaches spawn_rate
if (timer >= spawn_rate) {
    var e = instance_create_layer(x, y, "Instances", obj_enemy);

    // Scale enemy x2
    e.image_xscale = 2;
    e.image_yscale = 2;

    timer = 0;
}