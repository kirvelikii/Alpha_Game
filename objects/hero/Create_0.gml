if room != fight{
    team = inv_ruleset.team
    temp = true
}
if temp{
    max_hp = 100
    basic_attack = 5
    attack_interval = 60 * 1.5
    attack_delay = 10
    basic_range = 1
    basic_accuracy = 85
    dodge_chance = 5
    mov_speed = 1 / 5
    basic_target_count = 1
    basic_crit_chance = 10
    basic_crit_damage = 2
    name = "Template"
    skills = [template_skill]
    common_pos = "frontline"
    crit_eff = basic_crit_attack_effect
    eff = basic_attack_effect
    hp = max_hp 
}
attack_cooldown = attack_interval
statuses_visual = []
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
target = noone
function find_basic_target() {
    var potential_targets = [];
    
    // Собираем всех возможных целей
    with (hero) {
        if (team != other.team && hp > 0) {
            array_push(potential_targets, id);
        }
    }
    // Если есть цели - выбираем случайную
    if (array_length(potential_targets) > 0) {
        target = potential_targets[irandom(array_length(potential_targets)-1)];
    } else {
        target = noone;
        ruleset.check_win();
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
    var a = instance_create_layer(_target.x, _target.y, "effects", effect, {sprite_index: eff, constant: false, image_xscale: _target.image_xscale})
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
