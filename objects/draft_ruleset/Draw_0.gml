draw_set_alpha(0.5)
draw_rectangle_color(0, 0, 512, 768, c_blue, c_black, c_black, c_blue, 0)
draw_rectangle_color(512, 0, 512 + 64* 5, 768, c_black, c_black, c_black, c_black, 0)
draw_rectangle_color(512 + 64* 5, 0, room_width, 768, c_black, c_red, c_red, c_black, 0)
draw_set_alpha(1)
if turn == 1{
    var col = c_blue
}
else{
    var col = c_red
}
if !full{
    draw_text_transformed_color(512, 0, string(turn) + " Player picking:", 2, 2, 0, col, c_white, c_white, col, 1)
}
else{
    draw_text_transformed_color(512 + 64, 0, "Draft Done!", 2, 2, 0, c_white, c_white, c_white, c_white, 1)
}