depth = 100
if inv_ruleset.team == 1{
    if collision_rectangle(100, 0, 356, 768, self, false, false) and is_dragging{
    var t = array_length(global.layout_t1[0])
    y = 128 * (t % 6)
    x = 228 - 128 * floor(t / 6)
    array_push(global.layout_t1[0], self)
    equipped = 1
}
else if collision_rectangle(356, 0, 356+256, 768, self, false, false) and is_dragging{
    var t = array_length(global.layout_t1[1])
    y = 128 * (t % 6)
    x = 356 + 128 - 128 * floor(t / 6)
    array_push(global.layout_t1[1], self)
    equipped = 2
}
else if collision_rectangle(356+256, 0, 356+512, 768, self, false, false) and is_dragging{
    var t = array_length(global.layout_t1[2])
    y = 128 * (t % 6)
    x = 356 + 256 + 128 - 128 * floor(t / 6)
    array_push(global.layout_t1[2], self)
    equipped = 3
}
else if is_dragging{
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0
}
}
else{
    if collision_rectangle(100, 0, 356, 768, self, false, false) and is_dragging{
        var t = array_length(global.layout_t1[2])
        y = 128 * (t % 6)
        x = 228 + 128 * floor(t / 6)
        array_push(global.layout_t1[2], self)
        equipped = 1
}
else if collision_rectangle(356, 0, 356+256, 768, self, false, false) and is_dragging{
    var t = array_length(global.layout_t1[1])
    y = 128 * (t % 6)
    x = 356 + 128 + 128 * floor(t / 6)
    array_push(global.layout_t1[1], self)
    equipped = 2
}
else if collision_rectangle(356+256, 0, 356+512, 768, self, false, false) and is_dragging{
    var t = array_length(global.layout_t1[0])
    y = 128 * (t % 6)
    x = 356 + 256 + 128 + 128 * floor(t / 6)
    array_push(global.layout_t1[0], self)
    equipped = 3
}
else if is_dragging{
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 128 + 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0
}
}
is_dragging = false;
inv_ruleset.drag_obj = noone