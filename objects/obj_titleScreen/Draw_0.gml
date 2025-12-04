// Draw title sprite
draw_sprite_ext(
    spr_titleScreen, 
    0, 
    room_width/2 - sprite_width/2, 
    room_height/2 - sprite_height/2, 
    1,1,0,c_white,1
);

// Draw animated "Press Enter to Start"
draw_set_alpha(text_alpha);
draw_set_color(c_white);
var text_str = "Press Enter to Start";
var text_x = room_width/2 - string_width(text_str)/2;
var text_y = room_height - 700;
draw_text(text_x, text_y, text_str);
draw_set_alpha(1);

// Draw fade overlay if fading
if (fade_out) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}