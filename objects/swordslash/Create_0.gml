/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if temp{
    host = {basic_attack: 0}
    name = "Взмах меча"
description = "Выглядит незаурядно, но доставит много проблем тем, кто попадет под него"
type = swordslash 
skill_power = 10  
    atk_perc = 60
skill_power_shown_formula = ["/skill_power", " + ", "/atk_perc", "% от базовой атаки"]
range = 1
target_type = "Враг"
sub_target_count = 0
damage_to_targets = [1]
aoe = true
aoe_range = 1
aoe_horizontal_range = 0
aoe_damage = [1]
crit_chance = 5
crit_damage = 2.5
cooldown = 60 * 4
cast_delay = [40, 60]
animation_delay = 30
ready = false
cd = cooldown * 0.5
restrictions = []
target = noone
sub_targets = []
eff = swordslash_effect
effects_on_use = []
}
function use_skill(_target, main_target=true, modifers = undefined){
    if !instance_exists(_target){return }
    var crit = irandom(100)
    var attack_power = (skill_power + atk_perc / 100 * host.basic_attack)* modifers.sub_target_modifer
    if crit <= crit_chance{
        attack_power *= crit_damage
    }
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
    _target.get_damage(attack_power, "skill", host, 0, 0, uid)
    for (var i = 0; i < array_length(effects_on_use); i++){
        if effects_on_use[i][1] == "target_and_sub_enemy" or (main_target and effects_on_use[i][1] == "main_target_enemy") or (!main_target and effects_on_use[i][1] == "sub_target_enemy"){ 
            apply_effect(_target, effects_on_use[i][0], effects_on_use[i][2], effects_on_use[i][3])
        }
    }
} 