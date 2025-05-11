if collision_rectangle(100, 0, 356, 768, self, false, false) and is_dragging {
    var t = array_length(global.layout_t1[0])
    if inv_ruleset.team == 1{
        draw_rectangle_color(228 - 128 * floor(t / 6), 128 * (t % 6) , 228 - 128 * floor(t / 6) + 128, 128 * (t % 6) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
    }
    else{
        draw_rectangle_color(228 + 128 - 128 * floor(t / 6), 128 * (t % 6) , 228 - 128 * floor(t / 6) + 128, 128 * (t % 6) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
    }
}
else if collision_rectangle(356, 0, 356+256, 768, self, false, false) and is_dragging {
    var t = array_length(global.layout_t1[1])
    draw_rectangle_color(356 + 128 - 128 * floor(t / 6), 128 * (t % 6) , 356 + 128 - 128 * floor(t / 6) + 128, 128 * (t % 6) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
}
else if collision_rectangle(356+256, 0, 356+512, 768, self, false, false) and is_dragging {
    var t = array_length(global.layout_t1[2])
    draw_rectangle_color(356 + 256 + 128 - 128 * floor(t / 6), 128 * (t % 6) , 356 + 256 + 128 + 128 - 128 * floor(t / 6), 128 * (t % 6) + 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
}
draw_self()