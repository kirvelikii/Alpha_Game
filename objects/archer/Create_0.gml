/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if temp{
    type = archer
    sprite_index = sp_archer
    max_hp = 100
    basic_attack = 6
    attack_interval = 60 * 1.2
    attack_delay = 60
    basic_range = 3
    fear_range = 2
    basic_accuracy = 75
    dodge_chance = 10
    mov_speed = 1 / 1.8
    basic_target_count = 1
    basic_crit_chance = 30
    basic_crit_damage = 2.2
    name = "Лучник"
    lore = "Легкий воин дальнего боя, при должных стараниях лук в его руках станет орудием, несущем смерть на расстоянии"
    skills = [arrow_rain]
    for (var i = 0; i < array_length(skills); i++){
        skills[i] = object_get_safe_stats_shown(skills[i])
        //instance_create_layer(x - 64 * (i+1), y, "Instances", skills[i], {host: id})
        //instance_create_layer(x +  64 * (i+1), y, "Instances", skills[i], {host: id, image_xscale: -1})
    }
    legacy_skills = [arrow_rain]
    equips = []
    common_pos = "frontline"
    crit_eff = archer_effect
    eff = archer_effect_crit
    eff_type = "projectile"
    stats_proj = {sspeed: 45, source: id, land_eff: archer_effect_landed, land_dl: 60}
    hp = max_hp 
    max_sanity = 150
    low_sanity_effect = {s50: "retreat", s25: "panic", s0: "crazy"}
    damage_to_sanity = {damage: {hp75: 0.55, hp50:0.75, hp25:1.6, hp10: 4}, ally_death:{row: 20, glob: 6}}
    heal_sanity = {kill: 20, enemy_death:{row: 5, glob: 0}, succesful_retreat: 0.4, sanity_on_panic: 0.4}
    state = "normal"
    modifer = { 
    max_hp: -0.2,
    basic_attack: 0.1,
    basic_range: 0,
    attack_interval: -0.1,
    basic_accuracy: 0,
    basic_crit_chance: 0.1,
    basic_crit_damage: 0,
    dodge_chance: 0.1,
    mov_speed: 0.1,
    max_sanity: 0,
    }
    focus_tree = [
    
    ]
}
stats_proj.source = self