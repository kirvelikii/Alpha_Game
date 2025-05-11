if collision_rectangle(0, 0, 768, 256, self, false, false) and is_dragging {
    var t = array_length(global.equips[inv_ruleset.team-1][0])
    draw_rectangle_color(128 + 64 * (t % 10), 0 + 64 * floor(t / 10) , 128+64 + 64 * (t % 10), 64 + 64 * floor(t / 10), c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
}
else if collision_rectangle(0, 256, 768, 512, self, false, false) and is_dragging {
    var t = array_length(global.equips[inv_ruleset.team-1][1])
    draw_rectangle_color(128 + 64 * (t % 10), 256 + 64 * floor(t / 10) , 128+64 + 64 * (t % 10), 256 + 64 + 64 * floor(t / 10), c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
}
else if collision_rectangle(0, 512, 768, 768, self, false, false) and is_dragging {
    var t = array_length(global.equips[inv_ruleset.team-1][2])
    draw_rectangle_color(128 + 64 * (t % 10), 512 + 64 * floor(t / 10) , 128+64 + 64 * (t % 10), 512 + 64 + 64 * floor(t / 10), c_ltgray, c_ltgray, c_ltgray, c_ltgray, 0)
}
draw_self()