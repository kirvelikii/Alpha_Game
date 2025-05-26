/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if temp{
    type = warrior
    max_hp = 175
    basic_attack = 7.5
    attack_interval = 60 * 1.6
    attack_delay = 15
    basic_range = 1
    basic_accuracy = 80
    dodge_chance = 5
    mov_speed = 1 / 2.5
    basic_target_count = 1
    basic_crit_chance = 20
    basic_crit_damage = 1.8
    name = "Воин"
    lore = "Человек, избравший путь меча, его сердце наполнено храбростью, а меч в его руках становится грозным оружием для всех врагов"
    skills = [swordslash]
    legacy_skills = [swordslash]
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
    max_hp: 0.3,
    basic_attack: 0.1,
    basic_range: 0,
    attack_interval: -0.1,
    basic_accuracy: 0,
    basic_crit_chance: 0,
    basic_crit_damage: 0,
    dodge_chance: 0,
    mov_speed: -0.2,
    max_sanity: 0,
    }
    focus_tree = [
    {
        focus_id: "Сила воли",
        focus_name: "Сила воли",
        focus_description: "Чтобы кого-то защитить, нужно по крайней мере не упасть после первого удара протвника",
        focus_cost: 100,
        focus_prerequisites: [],
        focus_restrictions: [],
        focus_unlocked: false,
        focus_icon: strong_will,
        stat_changes: [["max_hp_perc", 0.1], ["max_hp", 50]],
        gives: []
    },
    {
        focus_id: "Крепче камня",
        focus_name: "Крепче камня",
        focus_description: "Будь как неприступный утес на берегу бушующего океана",
        focus_cost: 200,
        focus_prerequisites: ["Сила воли"],
        focus_restrictions: ["fСила воли", "sdamage_taken:total:>:250"],
        focus_unlocked: false,
        focus_icon: stronger_rock,
        stat_changes: [["max_hp_perc", 0.2]],
        gives: [["buff", [defense_up, {potency: 5}, {}]]]
    },
    
    ]
}