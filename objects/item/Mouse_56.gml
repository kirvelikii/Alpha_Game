depth = 100

if collision_rectangle(0, 0, 768, 256, self, false, false) and is_dragging{
    var t = array_length(global.equips[inv_ruleset.team-1][0])
    x = 128 + 64 * (t % 10)
    y =  0 + 64 * floor(t / 10)
    array_push(global.equips[inv_ruleset.team-1][0], self)
    equipped = 1
}
else if collision_rectangle(0, 256, 768, 512, self, false, false) and is_dragging{
    var t = array_length(global.equips[inv_ruleset.team-1][1])
    x = 128 + 64 * (t % 10)
    y =  256 + 64 * floor(t / 10)
    array_push(global.equips[inv_ruleset.team-1][1], self)
    equipped = 2
}
else if collision_rectangle(0, 512, 768, 768, self, false, false) and is_dragging{
    var t = array_length(global.equips[inv_ruleset.team-1][2])
    x = 128 + 64 * (t % 10)
    y =  512 + 64 * floor(t / 10)
    array_push(global.equips[inv_ruleset.team-1][2], self)
    equipped = 3
}
else if is_dragging{
    array_push(global.lootobj[inv_ruleset.team - 1], self)
    equipped = 0
}
is_dragging = false;
inv_ruleset.drag_obj = noone
inv_ruleset.check_spaces()