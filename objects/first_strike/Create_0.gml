/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Первый удар"
description = "Важно правильно начинать, продолжить сможет каждый"
skill_power = 40
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