if is_dragging{
    if inv_ruleset.team == 1{
    if equipped != 0{
        //show_message(floor((y - (equipped - 1) * 256) / 64) * 10+ floor((x - 128)/ 64))
        array_delete(global.layout_t1[equipped-1], floor((100 + (equipped - 1) * 256) / 128 - x) * 6 + floor(y / 128), 1)
        //show_debug_message(global.equips[inv_ruleset.team-1])
        inv_ruleset.check_spaces_eq(equipped)
        equipped = 0
    }
    else{
        //show_message(floor((y - (equipped - 1) * 256) / 64) * 10+ floor((x - 128)/ 64))
        //show_debug_message([floor((y - 60) / 8), floor((x - 768)/ 64)])
        array_delete(global.not_sorted_t1, floor((y - 64)/ 128) + floor((x - 925)/ 128), 1)
        //show_debug_message(global.lootobj[inv_ruleset.team-1])
        inv_ruleset.check_spaces()
        equipped = 0
        }}
    else{
        if equipped != 0{
        //show_message(floor((y - (equipped - 1) * 256) / 64) * 10+ floor((x - 128)/ 64))
        array_delete(global.layout_t1[3-equipped], floor((x - 100 - 128 - (equipped - 1) * 256) / 128) * 6 + floor(y / 128), 1)
        //show_debug_message(global.equips[inv_ruleset.team-1])
        inv_ruleset.check_spaces_eq(equipped)
        equipped = 0
    }
    else{
        //show_message(floor((y - (equipped - 1) * 256) / 64) * 10+ floor((x - 128)/ 64))
        //show_debug_message([floor((y - 60) / 8), floor((x - 768)/ 64)])
        array_delete(global.not_sorted_t1, floor((y - 64 - 128)/ 128) + floor((x - 925)/ 128), 1)
        //show_debug_message(global.lootobj[inv_ruleset.team-1])
        inv_ruleset.check_spaces()
        equipped = 0
        }
    }
    }