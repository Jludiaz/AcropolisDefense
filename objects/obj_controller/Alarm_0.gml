/// obj_gameController - Alarm 0
if (wave_index < array_length(waves)) {
    var wave = waves[wave_index];
    var num_basic = wave[0];
    var num_fast  = wave[1];
    var num_tank  = wave[2];

    // spawn with small stagger using alarms on controller
    // we'll spawn all basics, then fasts, then tanks with short delay:
    var delay = 0;
    for (var i = 0; i < num_basic; i++) {
        alarm[1 + i + delay] = i * room_speed * 0.6; // stagger
        // store spawn info in an array for Alarm handlers
        // we'll attach type info by setting a spawn queue:
    }
    // for simplicity spawn immediately in loops:
    for (var i = 0; i < num_basic; i++) instance_create_layer(spawn_x + irandom_range(0,100), spawn_y + irandom_range(-120,120), "Instances", obj_enemy_basic);
    for (var i = 0; i < num_fast;  i++) instance_create_layer(spawn_x + irandom_range(0,100), spawn_y + irandom_range(-120,120), "Instances", obj_enemy_fast);
    // increment wave index, set next wave timer
    wave_index++;
    alarm[0] = room_speed * 8; // next wave after 8s
} else {
    // all waves done - you can set wave_running false or check win condition
    wave_running = false;
}