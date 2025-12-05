draw_self();
// Draw splash radius preview when close to target
if (instance_exists(target_id)) {
    if (point_distance(x, y, target_id.x, target_id.y) < 50) {
        draw_set_color(c_orange);
        draw_set_alpha(0.3);
        //draw_circle(x, y, splash_radius, false);
        draw_set_alpha(1);
    }
}