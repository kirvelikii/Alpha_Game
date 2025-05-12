if state == "normal"{
attack_cooldown -= 1;
if (attack_cooldown <= 0) {
    // Случайный разброс интервала атаки (±20% от базового)
    if (!instance_exists(target)){
        find_basic_target();
    }
    
    if (instance_exists(target)) {
        if abs(floor(distance_to_target(target) + moving_progress)) < basic_range{
            attack(target);
            attack_cooldown = attack_interval * (0.8 + random(0.4));
            //show_message(distance_to_target(target))
                    // 10% шанс сменить цель после атаки
            if (irandom(100) < 10) {
            find_basic_target();
        }
        }
        else{
            target = noone
            find_basic_target()
        }
        

    }
}
if need_pos < 0{target_to_move = noone}
if instance_exists(target_to_move){
    if !is_moving{
        is_moving = 1
        directionn = abs(need_pos - pos) / (need_pos - pos)
        moving_progress = 0
    }
        moving_progress += (mov_speed  * (0.8 + random(0.4)) / 60)
    if moving_progress >= 1{
        //show_debug_message(pos)
        //show_debug_message(array_find_index(ruleset.battlefield[pos], function(item) { show_message([id, item.id])return item == id; }))
        array_delete(ruleset.battlefield[pos], array_find_instance(ruleset.battlefield[pos], self), 1)
        pos += directionn
        //show_debug_message(pos)
        x += directionn * 256
        array_push(ruleset.battlefield[pos], id)
        ruleset.check_spaces()
        show_debug_message(ruleset.battlefield)
        //show_debug_message(directionn)
        moving_progress = 0
        find_basic_target()
    }
    if need_pos == pos{
        is_moving = 0
        moving_progress = 0
        directionn = 0
        find_basic_target()
    }}
else{
    is_moving = 0
    moving_progress = 0
    directionn = 0
}}
else if state == "retreat"{
    target = noone
    target_to_move = noone
    if retr_target_row == pos{
        is_moving = 0
        moving_progress = 0
        directionn = 0
        healing_sanity = true
        check_sanity()
}
    else{
    moving_progress += (retr_speed  * (0.8 + random(0.4)) / 60)
    if moving_progress >= 1{
        //show_debug_message(pos)
        //show_debug_message(array_find_index(ruleset.battlefield[pos], function(item) { show_message([id, item.id])return item == id; }))
        array_delete(ruleset.battlefield[pos], array_find_instance(ruleset.battlefield[pos], self), 1)
        pos += directionn
        //show_debug_message(pos)
        x += directionn * 256
        array_push(ruleset.battlefield[pos], id)
        ruleset.check_spaces()
        show_debug_message(ruleset.battlefield)
        //show_debug_message(directionn)
        moving_progress = 0}
    }
}
if (hp <= 0) {
    with hero{
        if team == other.team and other.id != id{
            if pos = other.pos{
                change_sanity(-1, "ally_death_row")
            }
            else{
                change_sanity(-1, "ally_death_global")
            }
        }
    }
    instance_destroy();
    ruleset.check_spaces()
    ruleset.check_win();
}
else if state == "panic"{
    target = noone
    target_to_move = noone
    if irandom(max_sanity) <= sanity{
        sanity += heal_sanity.sanity_on_panic
        check_sanity()
    }
    else{
    moving_progress += (retr_speed  * (0.8 + random(0.4)) / 60)
    if moving_progress >= 1{
        
        //show_debug_message(pos)
        //show_debug_message(array_find_index(ruleset.battlefield[pos], function(item) { show_message([id, item.id])return item == id; }))
        array_delete(ruleset.battlefield[pos], array_find_instance(ruleset.battlefield[pos], self), 1)
        pos += directionn
        if esc_target_row == pos{
            instance_destroy(self)
            ruleset.check_spaces()
            ruleset.check_win()
        }
        else{
            //show_debug_message(pos)
        x += directionn * 256
        array_push(ruleset.battlefield[pos], id)
        ruleset.check_spaces()
        show_debug_message(ruleset.battlefield)
        //show_debug_message(directionn)
        moving_progress = 0
        }
        }
    }
}
else if state == "crazy"{
    //show_debug_message([target, target_to_move, moving_progress, directionn, is_moving])
    attack_cooldown -= 1;
if (attack_cooldown <= 0) {
    // Случайный разброс интервала атаки (±20% от базового)
    if (!instance_exists(target)){
        find_anything_target()
    }
    
    if (instance_exists(target)) {
        if abs(floor(distance_to_target(target) + moving_progress)) < basic_range{
            attack(target);
            //show_message(target)
            attack_cooldown = crazy_attack_speed * (0.8 + random(0.4));
            //show_message(distance_to_target(target))
                    // 10% шанс сменить цель после атаки
            if (irandom(100) < 50) {
                find_anything_target()
            }
        }
        else{
            target = noone
            find_anything_target()
        }
        

    }
}
if need_pos < 0{target_to_move = noone}
if instance_exists(target_to_move){
    if !is_moving{
        is_moving = 1
        directionn = abs(need_pos - pos) / (need_pos - pos)
        moving_progress = 0
    }
        moving_progress += (crazy_speed * (0.8 + random(0.4)) / 60)
    if moving_progress >= 1{
        //show_debug_message(pos)
        //show_debug_message(array_find_index(ruleset.battlefield[pos], function(item) { show_message([id, item.id])return item == id; }))
        array_delete(ruleset.battlefield[pos], array_find_instance(ruleset.battlefield[pos], self), 1)
        pos += directionn
        //show_debug_message(pos)
        x += directionn * 256
        array_push(ruleset.battlefield[pos], id)
        ruleset.check_spaces()
        show_debug_message(ruleset.battlefield)
        //show_debug_message(directionn)
        moving_progress = 0
        find_anything_target()
    }
    if need_pos == pos{
        is_moving = 0
        moving_progress = 0
        directionn = 0
        find_anything_target()
    }}
else{
    find_anything_target()
    }}
if (hp <= 0) {
    with hero{
        if team == other.team and other.id != id{
            if pos = other.pos{
                change_sanity(-1, "ally_death_row")
            }
            else{
                change_sanity(-1, "ally_death_global")
            }
        }
    }
    instance_destroy();
    ruleset.check_spaces()
    ruleset.check_win();
}
//show_debug_message([target_to_move, pos, need_pos])
if healing_sanity{
    sanity += heal_sanity.succesful_retreat
}