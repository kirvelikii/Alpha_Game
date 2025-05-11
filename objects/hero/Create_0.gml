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
    skills = []
    common_pos = "frontline"
    crit_eff = basic_crit_attack_effect
    eff = basic_attack_effect
    hp = max_hp 
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

function find_basic_target() {
    var potential_targets = [];
    
    // Собираем всех возможных целей
    
    with (hero) {
        if (team != other.team && hp > 0) and floor(abs(distance_to_target(other) + directionn)) < other.basic_range {
            array_push(potential_targets, id);
        }
    }
    // Если есть цели - выбираем случайную
    if (array_length(potential_targets) > 0) {
        target = potential_targets[irandom(array_length(potential_targets)-1)];
        moving = 0
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
            show_debug_message(min_range)
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