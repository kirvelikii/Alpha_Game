// В Global Left Pressed Event или в Step Event
if is_dragging{
    if equipped != 0{
        //show_message(floor((y - (equipped - 1) * 256) / 64) * 10+ floor((x - 128)/ 64))
        array_delete(global.equips[inv_ruleset.team-1][equipped-1], floor((y - (equipped - 1) * 256) / 64) * 10 + floor((x - 128)/ 64), 1)
        //show_debug_message(global.equips[inv_ruleset.team-1])
        inv_ruleset.check_spaces_eq(equipped)
        equipped = 0
    }
    else{
        //show_message(floor((y - (equipped - 1) * 256) / 64) * 10+ floor((x - 128)/ 64))
        show_debug_message([floor((y - 60) / 8), floor((x - 768)/ 64)])
        array_delete(global.lootobj[inv_ruleset.team-1], floor((y - 60) / 8) + floor((x - 768)/ 64), 1)
        show_debug_message(global.lootobj[inv_ruleset.team-1])
        inv_ruleset.check_spaces()
        equipped = 0
        }
    }