//draw_healthbar(x, y, y + 128, x + 20 * image_xscale, hp / max_hp, c_red, c_black, c_lime, 3, false, false)
if global.chosen_pers == self{
    draw_rectangle_color(x - image_xscale * 5, y - 5, x + image_xscale * 133, y + 133, c_yellow, c_yellow, c_yellow, c_white, true)
}
if image_xscale == 1{
    draw_sprite_ext(aff, 1, x + 96, y, 0.5, 0.5, 0, afc, 1)
}
else{
    draw_sprite_ext(aff, 1, x - 128, y, 0.5, 0.5, 0, afc, 1)
}
