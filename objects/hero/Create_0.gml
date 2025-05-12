if room != fight{
    team = inv_ruleset.team
}
if temp{
    max_hp = 100
    basic_attack = 5
    attack_interval = 60 * 1.5
    attack_delay = 10
    basic_range = 1
    basic_accuracy = 85
    dodge_chance = 5
    mov_speed = 1 / 2
    basic_target_count = 1
    basic_crit_chance = 50
    basic_crit_damage = 2
    name = "Template"
    skills = [template_skill]
    common_pos = "frontline"
    crit_eff = basic_crit_attack_effect
    eff = basic_attack_effect
    hp = max_hp 
    max_sanity = 100
    sanity = 100
    low_sanity_effect = {s50: "retreat", s25: "panic", s0: "crazy"}
    damage_to_sanity = {damage: {hp75: 0.45, hp50:0.65, hp25:1.5, hp10: 3}, ally_death:{row: 15, glob: 8}}
    heal_sanity = {kill: 20, enemy_death:{row: 5, glob: 0}, succesful_retreat: 0.4, sanity_on_panic: 0.4}
    state = "normal"
}
else{
    if team == 1{
    image_xscale = 1
    for (var i = 0; i < array_length(skills); i++){
        instance_create_layer(x - 64 * (i+1), y, "Instances", skills[i], {host: id})
    }
}
else if team == 2{
    image_xscale = -1
    for (var i = 0; i < array_length(skills); i++){
        instance_create_layer(x +  64 * (i+1), y, "Instances", skills[i], {host: id, image_xscale: -1})
    }
}
}
chosen = 0
attack_cooldown = attack_interval
statuses_visual = []
target = noone
target_to_move = noone
need_pos = 0
moving_progress = 0
is_moving = 0
directionn = 0
healing_sanity = false
if team == 1{
    retr_target_row = 0
    esc_target_row = -1 
}
else{
    retr_target_row = 6
    esc_target_row = 7
}
retr_speed = mov_speed * 2
crazy_speed = mov_speed * 2.5
crazy_attack_speed = attack_interval * 0.75
function find_basic_target() {
    var potential_targets = [];
    
    // Собираем всех возможных целей
    
    with (hero) {
        if ((team != other.team or state == "crazy") && hp > 0) and floor(abs(distance_to_target(other) + directionn)) < other.basic_range {
            array_push(potential_targets, id);
        }
    }
    // Если есть цели - выбираем случайную
    if (array_length(potential_targets) > 0) {
        target = potential_targets[irandom(array_length(potential_targets)-1)];
        is_moving = 0
        moving_progress = 0
        target_to_move = noone
        directionn = 0
    } else {
        target = noone;
        ruleset.check_win();
        if !is_moving{
        var min_range = 999999999
        with (hero) {
        if (team != other.team && hp > 0) and abs(distance_to_target(other)) <= abs(min_range) {
            if min_range == distance_to_target(other){ 
                array_push(potential_targets, id);
            }
            else{
                potential_targets = []
                array_push(potential_targets, id);
            }
            min_range = distance_to_target(other)
            //show_debug_message(min_range)
        }}
        if array_length(potential_targets) > 0{ 
            target_to_move = potential_targets[irandom(array_length(potential_targets)-1)];   
            need_pos = pos + min_range }    
        }    

    }
}
function attack(_target, modifers=[]){
    if !instance_exists(_target){return }
    var crit = irandom(100)
    var is_crit = false
    var attack_power = basic_attack
    if crit <= basic_crit_chance{
        attack_power *= basic_crit_damage
        is_crit = true
    }
    show_debug_message("Attack:" + name + " (" + string(team) + ") базовый урон - "+ string(attack_power) + ", врага "+ _target.name + " ("+ string(_target.team) + "), оставшееся хп - " + string(_target.hp - attack_power))
    _target.get_damage(attack_power, "attack", self)
    if is_crit{
        show_effect(_target, crit_eff)
    }
    else{
        show_effect(_target, eff)
    }
    
}
function show_effect(_target, _effect){
    var a = instance_create_layer(_target.x, _target.y, "effects", effect, {sprite_index: _effect, constant: false, image_xscale: _target.image_xscale, host: _target})
}
function get_damage(n, type, dealer){
    var total = n
    var atk_modifer = 1
    for (var i =0; i < array_length(statuses_visual); i++){
        if statuses_visual[i].name == "fragility"{
            atk_modifer += statuses_visual[i].potency / 100
        } 
    }
    change_sanity(-1, "damage", total * atk_modifer)
    hp -= total * atk_modifer
}
function distance_to_target(_target){
    var a = id
    var b = _target.id
    var an = -1
    var bn = -1
    //show_message([a, b, ruleset.battlefield])
    for (var i = 0; i < array_length(ruleset.battlefield); i++){
        if array_contains(ruleset.battlefield[i], a){
            an = i
        }
        if array_contains(ruleset.battlefield[i], b){
            bn = i
        }
    }
    if an>-1 and bn>-1{
        return (an - bn)
    }
    else{
        return 9999999
    }}


function array_find_instance(_array, instance_to_find) {
    // Проверка входящих данных
    if (!is_array(_array)) {
        show_debug_message("Ошибка: первый аргумент не массив!");
        return -1;
    }
    
    if (!instance_exists(instance_to_find)) {
        show_debug_message("Ошибка: второй аргумент не экземпляр!");
        return -1;
    }
    
    // Поиск по уникальному ID экземпляра
    var target_id = instance_to_find.id;
    
    for (var i = 0; i < array_length(_array); i++) {
        var itemm = _array[i];
        
        // Проверяем, является ли элемент экземпляром
        if (instance_exists(itemm)) {
            // Сравниваем по уникальному ID
            if (itemm.id == target_id) {
                return i; // Найден
            }
        }
    }
    
    return -1; // Не найден
}
function change_sanity(alter, type, val=0){
    if alter = -1{
        healing_sanity = 0
        if type == "damage"{
            var hp_proc = hp / max_hp * 100
            var keys = struct_get_names(damage_to_sanity.damage)
            for (var i = array_length(keys)-1; i>=0; i--){
                if hp_proc < int64(string_replace(keys[i], "hp", "")){
                    sanity -= val * damage_to_sanity.damage[$ keys[i]]
                    //show_message([hp, hp_proc, keys[i], sanity])
                    break
                }
            }
        }
        else if type == "ally_death_row"{
            sanity -= damage_to_sanity.ally_death.row
        }
        else if type == "ally_death_global"{ 
            sanity -= damage_to_sanity.ally_death.glob
        }
    }
    else{
        
    }
    check_sanity()
    show_debug_message([team, id, hp, sanity, state])
}
function check_sanity(){
    if state == "crazy" return
    var keys = struct_get_names(low_sanity_effect)
    state = "normal"
            for (var i = array_length(keys)-1; i>=0; i--){
                if sanity < int64(string_replace(keys[i], "s", "")){
                    state = low_sanity_effect[$ keys[i]]
                    switch_to_state(state)
                    //show_message([hp, hp_proc, keys[i], sanity])
                    break
                }
            }
}
function switch_to_state(st){
    if st == "retreat"{
        if team == 1{
            retr_speed = mov_speed * 2
            is_moving = 1
            directionn = -1
        }
        else{
            retr_target_row = 6
            retr_speed = mov_speed * 2
            is_moving = 1
            directionn = 1
        }
 
    }
    else if st == "panic"{
        if team == 1{
            is_moving = 1
            directionn = -1
        }
        else{
            is_moving = 1
            directionn = 1
        }
    }
    else if st == "crazy"{
        directionn = 0
        is_moving = 0
        find_anything_target()
        if team == 1{
            attack_cooldown = crazy_attack_speed
        }
        else{
            attack_cooldown = crazy_attack_speed
        }
    }
}
function find_anything_target(state_ex=["crazy", "panic", "retreat"]){
    var potential_targets = [];
    // Собираем всех возможных целей
    
    with (hero) {
        //show_message([id!=other.id, array_contains(state_ex, state), team != other.team, (floor(abs(distance_to_target(other))) < other.basic_range)])
        if hp > 0 and id != other.id and (!array_contains(state_ex, state) or team != other.team) and (floor(abs(distance_to_target(other))) < other.basic_range) {
            array_push(potential_targets, id);
        }
    }
    // Если есть цели - выбираем случайную
    if (array_length(potential_targets) > 0) {
        target = potential_targets[irandom(array_length(potential_targets)-1)];
        //show_debug_message(floor(abs(distance_to_target(target) + directionn)))
        is_moving = 0
        moving_progress = 0
        target_to_move = noone
        directionn = 0
    } else {
        target = noone;
        ruleset.check_win();
        if !is_moving{
        var min_range = 999999999
        with (hero) {
        if hp > 0  and id != other.id and (!array_contains(state_ex, state) or team != other.team) and abs(distance_to_target(other)) <= abs(min_range) {
            //show_message([state_ex, state, team==other.team, array_contains(state_ex, state)])   
            if min_range == distance_to_target(other){ 
                array_push(potential_targets, id);
            }
            else{
                potential_targets = []
                array_push(potential_targets, id);
            }
            min_range = distance_to_target(other)
            //show_debug_message(min_range)
        }}
        if array_length(potential_targets) > 0{ 
            target_to_move = potential_targets[irandom(array_length(potential_targets)-1)];   
            need_pos = pos + min_range }    
        }    

    }
}