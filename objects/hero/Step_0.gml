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

if (hp <= 0) {
    instance_destroy();
    ruleset.check_spaces()
    ruleset.check_win();
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
        for (var t = 0; t < array_length(skills); t++){
            with skills[t]{
                x += other.directionn * 256
            }
        }
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
}
//show_debug_message([target_to_move, pos, need_pos])