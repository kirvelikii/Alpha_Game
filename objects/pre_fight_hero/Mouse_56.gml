depth = 100
if inv_ruleset.team == 1{
    if collision_rectangle(100, 128, 356, 768, self, true, false) and is_dragging{
    var t = array_length(global.layout_t1[0]) 
    if t < 10{
    y = 128 + 128 * (t % 5)
    x = 228 - 128 * floor(t / 5)
    array_push(global.layout_t1[0], self)
    equipped = 1}
        else{
            if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0
}
        }
}
else if collision_rectangle(356, 128, 356+256, 768, self, true, false) and is_dragging{
    var t = array_length(global.layout_t1[1])
    if t < 10{
    y = 128 + 128 * (t % 5)
    x = 356 + 128 - 128 * floor(t / 5)
    array_push(global.layout_t1[1], self)
    equipped = 2}
    else{
            if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0}
}
}
else if collision_rectangle(356+256, 128, 356+512, 768, self, true, false) and is_dragging{
    var t = array_length(global.layout_t1[2])
    if t < 10{
    y = 128 + 128 * (t % 5)
    x = 356 + 256 + 128 - 128 * floor(t / 5)
    array_push(global.layout_t1[2], self)
    equipped = 3}
    else{
            if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0}
}
}
else if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0
}
}
else{
    if collision_rectangle(100, 128, 356, 768, self, true, false) and is_dragging{
        var t = array_length(global.layout_t1[2])
        if t < 10{
        y = 128 + 128 * (t % 5)
        x = 228 + 128 * floor(t / 5)
        array_push(global.layout_t1[2], self)
        equipped = 1}
        else{
            if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 128 + 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0}
}
}
else if collision_rectangle(356, 128, 356+256, 768, self, true, false) and is_dragging{
    var t = array_length(global.layout_t1[1])
    if t < 10{
    y = 128 + 128 * (t % 5)
    x = 356 + 128 + 128 * floor(t / 5)
    array_push(global.layout_t1[1], self)
    equipped = 2}
    else{
            if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 128 + 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0}
}
}
else if collision_rectangle(356+256, 128, 356+512, 768, self, true, false) and is_dragging{
    var t = array_length(global.layout_t1[0])
    if t < 10{
    y = 128 + 128 * (t % 5)
    x = 356 + 256 + 128 + 128 * floor(t / 5)
    array_push(global.layout_t1[0], self)
    equipped = 3}
    else{
            if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 128 + 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0}
}
}
else if is_dragging{
    with chars_panel{event_user(0)}
    var t = array_length(global.not_sorted_t1)
    y = 64 + 128 * floor(t / 3)
    x = 128 + 925 + 128 * (t % 3)
    array_push(global.not_sorted_t1, self)
    equipped = 0
}
}
inv_ruleset.check_spaces()
is_dragging = false;
inv_ruleset.drag_obj = noone