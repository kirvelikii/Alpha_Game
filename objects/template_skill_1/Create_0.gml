/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if temp{
    name = "Vibe Template Skill"
description = "Данный текст показывает, что вы крутой ВАЙБМЕН"
skill_power = 30
skill_power_shown = "30"
skill_power_shown_formula = []
range = 2
target_type = "Враг"
sub_target_count = 1
damage_to_targets = [1]
crit_chance = 30
crit_damage = 2
cooldown = 60 * 3
cast_delay = [10, 15]
animation_delay = 5
ready = false
cd = cooldown
restrictions = []
target = noone
sub_targets = []
eff = basic_skill_effect
effects_on_use = [[fragility, "main_target_enemy", {potency:15}, {duration:240}]]
        statistics = {damage: {total: 0, record: 0, last: 0}}
}
