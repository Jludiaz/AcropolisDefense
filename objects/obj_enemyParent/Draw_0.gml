draw_self();
draw_set_color(c_red);
var bw=28;
draw_rectangle(x-bw/2, y - sprite_height/2 - 8, x+bw/2, y - sprite_height/2 - 2, false);
draw_set_color(c_green);
draw_rectangle(x-bw/2, y - sprite_height/2 - 8, x-bw/2 + bw*(hp/max_hp), y - sprite_height/2 - 2, false);