/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if temp{
    type = first_strike
name = "Первый удар"
description = "Важно правильно начинать, продолжить сможет каждый"
skill_power = 400
skill_power_shown = "40, X1.5 при ударе по уникальному врагу, +0.25 если макс здоровье у себя и цели"
range = 1
target_type = "Враг"
sub_target_count = 0
damage_to_targets = [1]
crit_chance = 5
crit_damage = 2.5
cooldown = 60 * 10
cast_delay = [40, 60]
animation_delay = 30
ready = false
cd = cooldown * 0
restrictions = []
target = noone
sub_targets = []
eff = first_strike_effect
effects_on_use = []
stroken_down = []
    }
function use_skill(_target, main_target=true, modifers = undefined){
    if !instance_exists(_target){return }
    var crit = irandom(100)
    var modifer = 1
    if _target.hp >= _target.max_hp{
        modifer += 0.25
    }
    if host.hp >= host.max_hp{
        modifer += 0.25
    }
    if !array_contains(stroken_down, _target.uid){
        array_push(stroken_down, _target.uid)
        modifer += 0.5
    }
    var attack_power = skill_power * modifers.sub_target_modifer * modifer
    if crit <= crit_chance{
        attack_power *= crit_damage
    }
    show_debug_message(host.name + " (" + string(host.team) + ")" + " использует " + name + " урон - "+ string(attack_power) + ", врага "+ _target.name + " ("+ string(_target.team) + "), оставшееся хп - " + string(_target.hp - attack_power) + " " + string(_target.pos - host.pos) + " дальность")
    _target.get_damage(attack_power, "skill", host, 0, 0, uid)
    for (var i = 0; i < array_length(effects_on_use); i++){
        if effects_on_use[i][1] == "target_and_sub_enemy" or (main_target and effects_on_use[i][1] == "main_target_enemy") or (!main_target and effects_on_use[i][1] == "sub_target_enemy"){ 
            apply_effect(_target, effects_on_use[i][0], effects_on_use[i][2], effects_on_use[i][3])
        }
    }
}