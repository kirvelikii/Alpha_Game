if state == "retreat"{
    var blink_timer = global.blink_time
    shader_set(shd_white_blink);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_intensity"), 
        (sin(blink_timer * 0.1) + 1) * 0.5);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_color"), 
        0.7, 0.7, 0.7);
    draw_self();
    
    shader_reset();
}
else if state == "panic" {
    var blink_timer = global.blink_time
    shader_set(shd_white_blink);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_intensity"), 
        (sin(blink_timer * 0.075) + 1) * 0.5);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_color"), 
        1.0, 1.0, 1.0);
    draw_self();
    
    shader_reset();
}
else if state = "crazy"{
    var blink_timer = global.blink_time
    shader_set(shd_white_blink);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_intensity"), 
        (sin(blink_timer * 0.05) + 1) * 0.5);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_color"), 
        0.7, 0.0, 0.0);
    draw_self();
    shader_reset()
}
else{
    draw_self()
}
draw_my_healthbar()
draw_set_halign(fa_center)
draw_set_color(c_white)
draw_text(x+image_xscale*64, y+128, round(hp))
if is_moving and state != "crazy"{
    draw_sprite_ext(moving_vector, 1, x - directionn * 32 + (directionn + image_xscale) / 2 * 128, y + 32, directionn, 1, 0, c_white, 0.8)
    draw_sprite_part_ext(moving_vector_filled, 1, 0, 0, moving_progress * 64, 64, x - directionn * 32 + (directionn + image_xscale) / 2* 128, y + 32, directionn, 1, c_white, 0.8)
}
if is_moving and state == "crazy"{
    var blink_timer = global.blink_time
    shader_set(shd_white_blink);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_intensity"), 
        (sin(blink_timer * 0.05) + 1) * 0.5);
    shader_set_uniform_f(shader_get_uniform(shd_white_blink, "blink_color"), 
        0.7, 0.0, 0.0);
    draw_sprite_ext(moving_vector, 1, x - directionn * 32 + (directionn + image_xscale) / 2 * 128, y + 32, directionn, 1, 0, c_white, 0.8)
    draw_sprite_part_ext(moving_vector_filled, 1, 0, 0, moving_progress * 64, 64, x - directionn * 32 + (directionn + image_xscale) / 2* 128, y + 32, directionn, 1, c_white, 0.8)
    shader_reset();
}
shader_reset()