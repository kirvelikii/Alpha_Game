draw_self()
draw_set_halign(fa_center)
if !rolling and drop !=noone{
    draw_text_transformed_color(x + 256, y - 500, "Congratulations, you won '" + string(drop.name) + "' rarity " + string(drop.rarity) + "!" , 2, 2, 0, col, col, col, col, 1)
}