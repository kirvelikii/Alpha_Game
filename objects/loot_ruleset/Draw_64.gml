draw_set_halign(fa_center)
draw_set_font(-1)
if team == 1{
    draw_text_transformed_color(200, 500, "Player 1\n Looting, rolls left: " + string(global.rolls[0]),  1.5, 1.5, 0, c_blue, c_aqua, c_aqua, c_blue, 1)
}
else{
    draw_text_transformed_color(room_width-200, 500, "Player 2\n Looting, rolls left: " + string(global.rolls[1]),  1.5, 1.5, 0, c_red, c_orange, c_orange, c_red, 1)
}
