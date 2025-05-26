/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if temp{
    type = hero_transformed
    max_hp = 200
    basic_attack = 20
    attack_interval = 60 * 1.0
    attack_delay = 10
    basic_range = 1
    basic_accuracy = 85
    dodge_chance = 5
    mov_speed = 1 / 2
    basic_target_count = 1
    basic_crit_chance = 80
    basic_crit_damage = 2
    name = "Имба Вайбмен"
    lore = "Крутой чувак йоу"
    skills = [template_skill_1]
    for (var i = 0; i < array_length(skills); i++){
        skills[i] = object_get_safe_stats_shown(skills[i])
        //instance_create_layer(x - 64 * (i+1), y, "Instances", skills[i], {host: id})
        //instance_create_layer(x +  64 * (i+1), y, "Instances", skills[i], {host: id, image_xscale: -1})
    }
    legacy_skills = [template_skill_1]
    equips = []
    common_pos = "frontline"
    crit_eff = basic_crit_attack_effect
    eff = basic_attack_effect
    hp = max_hp 
    max_sanity = 150
    low_sanity_effect = {s50: "retreat", s25: "panic", s0: "crazy"}
    damage_to_sanity = {damage: {hp75: 0.45, hp50:0.65, hp25:1.5, hp10: 3}, ally_death:{row: 15, glob: 8}}
    heal_sanity = {kill: 20, enemy_death:{row: 5, glob: 0}, succesful_retreat: 0.4, sanity_on_panic: 0.4}
    state = "normal"
    modifer = { 
    max_hp: 0.2,
    basic_attack: 0.5,
    basic_range: 0,
    attack_interval: 0,
    basic_accuracy: 0,
    basic_crit_chance: 0,
    basic_crit_damage: 0,
    dodge_chance: 0,
    mov_speed: 0,
    max_sanity: 0,
    }
    focus_tree = []
}