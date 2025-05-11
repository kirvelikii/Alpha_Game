draw_self()
draw_set_halign(fa_center)
draw_set_color(c_white)
draw_text(x+image_xscale*64, y+128, round(hp))
if is_moving{
    draw_sprite_ext(moving_vector, 1, x + directionn * 96, y + 32, directionn, 1, 0, c_white, 0.8)
    draw_sprite_part_ext(moving_vector_filled, 1, 0, 0, moving_progress * 64, 64, x + directionn * 96, y + 32, directionn, 1, c_white, 0.8)
}