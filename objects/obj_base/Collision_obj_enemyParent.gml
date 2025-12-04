// When hit by enemy
hp -= 1;
if (hp <= 0) {
    room_restart();
}

draw_self();
draw_set_color(c_red);
draw_rectangle(x-60,y-80,x+60,y-64,false);
draw_set_color(c_green);
draw_rectangle(x-60,y-80,x-60 + 120 * (hp/max_hp), y-64, false);