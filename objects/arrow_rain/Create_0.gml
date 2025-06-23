/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if temp{
    host = {basic_attack: 0}
    name = "Дождь из стрел"
description = "Смерть падает с небес"
type = arrow_rain
skill_power = 20
    dur = 180
    sh_dur = 3
    del = 15
    d = del
skill_power_shown_formula = ["Массив стрел, урон каждую 1/4 секунду ", "20 + 5% от атаки", ", длительность, ", "/sh_dur", " секунд"]
    active_skills = []
range = 3
    stat = {duration: 180}
target_type = "Враг"
sub_target_count = 0
damage_to_targets = [1]
aoe = false
aoe_range = 0
aoe_horizontal_range = 0
aoe_damage = []
crit_chance = 10
crit_damage = 1.5
cooldown = 60 * 6
cast_delay = [40, 60]
animation_delay = 30
ready = false
cd = cooldown * 0.5
restrictions = []
target = noone
sub_targets = []
eff = arrow_rain_effect
effects_on_use = []
}
function use_skill(_target, main_target=true, modifers = undefined){
    if !instance_exists(_target){return }
    var crit = irandom(100)
    var attack_power = skill_power
    if crit <= crit_chance{
        attack_power *= crit_damage
    }
    skill_power = 20 + host.basic_attack/20
    show_debug_message(host.name + " (" + string(host.team) + ")" + " использует " + name + " урон - "+ string(attack_power) + ", врага "+ _target.name + " ("+ string(_target.team) + "), оставшееся хп - " + string(_target.hp - attack_power) + " " + string(_target.pos - host.pos) + " дальность")
    if aoe{
        var index = array_get_index(ruleset.battlefield[_target.pos], _target)
        var line = []
        with hero{
            if team == _target.team and pos - _target.pos <= other.aoe_horizontal_range{
                array_push(line, id)
            }
        }
        array_sort(line, function(a, b) {
        var val_a = array_get_index(ruleset.battlefield[a.pos], a);
        var val_b = array_get_index(ruleset.battlefield[b.pos], b);
        
        if (val_a == val_b) return 0;
        return val_a - val_b; // Возрастание
    });
        for (var f = 0; f < array_length(line); f++){
            if line[f] == _target{
                //show_message(array_get_index(ruleset.battlefield[_target.pos], _target))
                //show_message(f)
                for (var g = 1; g <= aoe_range; g++){
                    if f-g>=0{
                        line[f-g].get_damage(attack_power * aoe_damage[g-1], "skill", host, 0, 0, uid)
                        //show_message(array_get_index(ruleset.battlefield[line[f-g].pos], line[f-g]))
                        //show_message(f-g)
                    }
                    if f+g < array_length(line){
                        line[f+g].get_damage(attack_power * aoe_damage[g-1], "skill", host, 0, 0, uid)
                        //show_message(array_get_index(ruleset.battlefield[line[f+g].pos], line[f+g]))
                        //show_message(f+g)
                    }
                }
            }
        }
    }
    array_push(active_skills, [_target, dur])
    //_target.get_damage(attack_power, "skill", host, 0, 0, uid)
    for (var i = 0; i < array_length(effects_on_use); i++){
        if effects_on_use[i][1] == "target_and_sub_enemy" or (main_target and effects_on_use[i][1] == "main_target_enemy") or (!main_target and effects_on_use[i][1] == "sub_target_enemy"){ 
            apply_effect(_target, effects_on_use[i][0], effects_on_use[i][2], effects_on_use[i][3])
        }
    }
} 