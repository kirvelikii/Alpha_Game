display_reset(0, true);
// Для GMS 2.3+ (struct):
global.items_db = {
    hero: {
        name: "New basic hero!",
        texture: sp_hero,
        chance: 0.35,
        rarity: "rare",
        pools: ["basic", "chars"],
        affinity: "all",
        type: "hero",
        obj: hero,
        owner: noone
    },
    damage_up: {
        name: "Damage UP!",
        texture: damage_up,
        chance: 0.5,
        rarity: "uncommon",
        pools: ["basic", "stats_up"],
        affinity: "all",
        type: "stat_up",
        effect: [["basic_attack_perc", 0.2], ["basic_attack", 10]],
        gives: [],
        obj: damage_up, 
        owner: noone
    },
    first_strike_ult:{
        name: "Ultimate: First Strike (С-Grade)",
        texture: first_strike_ult,
        chance: 0.2,
        rarity: "epic",
        pools: ["basic", "ultimate"],
        affinity: "all",
        type: "item",
        effect : [],
        gives: [["skill", first_strike]],
        owner: noone
    },
    armor_crusher:{
        name: "Armor Crusher",
        texture: sp_armor_crusher,
        chance: 0.25,
        rarity: "epic",
        pools: ["basic", "weapons"],
        affinity: "all",
        type: "item",
        effect : [["basic_attack_perc", 0.1], ["basic_attack", 20], ["basic_crit_chance", 20]],
        gives: [["buff", [armor_crush, {potency: 5, status_duration: 120}, {}]]],
        owner: noone
    }
};
room = pre_fight
global.chests_db = {
    basic: {
        name: "basic",
        items: ["hero", "damage_up", "first_strike_ult", "armor_crusher"]
    }
};
rolling = 0
col = c_black
rolling_items = []
time = 30
drop = noone
can_roll = true
chestt = "basic"
s = noone
sspeed = random_range(25, 30)
a = random_range(-0.07, -0.05)
new_r = (room_width + 128 / sspeed)