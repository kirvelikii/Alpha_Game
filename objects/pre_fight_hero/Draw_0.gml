if collision_rectangle(100, 128, 356, 768, self, false, false) and is_dragging {
    if inv_ruleset.team == 1{
        var t = array_length(global.layout_t1[0])
        if t < 10{
        draw_rectangle_color(228 - 128 * floor(t / 5), 128 + 128 * (t % 5) , 228 - 128 * floor(t / 5) + 128, 128 +128 * (t % 5) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)}
        else{draw_text_color(min(mouse_x + 200, 1200), min(mouse_y + 200, 600), "Недостаточно места в ряду! (максимум 10 юнитов)", c_red, c_red, c_red, c_red, 1)}
    }
    else{
        var t = array_length(global.layout_t1[2])
        if t < 10{
        draw_rectangle_color(100 + 128 * floor(t / 5), 128 + 128 * (t % 5) , 100 + 128 * floor(t / 5) + 128, 128 +128 * (t % 5) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)}
        else{draw_text_color(min(mouse_x + 200, 1200), min(mouse_y + 200, 600), "Недостаточно места в ряду! (максимум 10 юнитов)", c_red, c_red, c_red, c_red, 1)}
    }
}
else if collision_rectangle(356, 128, 356+256, 768, self, false, false) and is_dragging {
    var t = array_length(global.layout_t1[1])
    if inv_ruleset.team == 1{
        if t < 10{
        draw_rectangle_color(356 + 128 - 128 * floor(t / 5), 128 + 128 * (t % 5) , 356 + 128 - 128 * floor(t / 5) + 128, 128 +128 * (t % 5) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)}
        else{draw_text_color(min(mouse_x + 200, 1200), min(mouse_y + 200, 600), "Недостаточно места в ряду! (максимум 10 юнитов)", c_red, c_red, c_red, c_red, 1)}
}
    else{
        if t < 10{
        draw_rectangle_color(356 + 128 * floor(t / 5), 128 + 128 * (t % 5) , 356 + 128 * floor(t / 5) + 128, 128 +128 * (t % 5) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)}
        else{draw_text_color(min(mouse_x + 200, 1200), min(mouse_y + 200, 600), "Недостаточно места в ряду! (максимум 10 юнитов)", c_red, c_red, c_red, c_red, 1)}
    }
}
else if collision_rectangle(356+256, 128, 356+512, 768, self, false, false) and is_dragging {
    if inv_ruleset.team == 1{
        var t = array_length(global.layout_t1[2])
        if t < 10{
        draw_rectangle_color(356 + 256 + 128 - 128 * floor(t / 5), 128 + 128 * (t % 5) , 356 + 256 + 128 + 128 - 128 * floor(t / 5), 128 +128 * (t % 5) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)}
    else{draw_text_color(min(mouse_x + 200, 1200), min(mouse_y + 200, 600), "Недостаточно места в ряду! (максимум 10 юнитов)", c_red, c_red, c_red, c_red, 1)}}
    else{
        var t = array_length(global.layout_t1[0])
        if t < 10{
        draw_rectangle_color(356 + 256 + 128 * floor(t / 5), 128 + 128 * (t % 5) , 356 + 256 + 128 + 128 * floor(t / 5), 128 +128 * (t % 5) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)}
        else{draw_text_color(min(mouse_x + 200, 1200), min(mouse_y + 200, 600), "Недостаточно места в ряду! (максимум 10 юнитов)", c_red, c_red, c_red, c_red, 1)}
    }
}
draw_self()
if equipped != 0 and unl{
    draw_sprite(redyy, 1, x + 32 * (image_xscale-1)/2, y)
}