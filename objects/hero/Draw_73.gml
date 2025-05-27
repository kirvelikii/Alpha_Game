//draw_healthbar(x, y, y + 128, x + 20 * image_xscale, hp / max_hp, c_red, c_black, c_lime, 3, false, false)
if global.chosen_pers == self{
    draw_rectangle_color(x - image_xscale * 5, y - 5, x + image_xscale * 133, y + 133, c_yellow, c_yellow, c_yellow, c_white, true)
}