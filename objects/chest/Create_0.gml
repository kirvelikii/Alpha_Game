display_reset(0, true);
// Для GMS 2.3+ (struct):
global.items_db = {
    hero: {
        name: "New basic hero!",
        texture: sp_hero,
        chance: 0.5,
        rarity: "uncommon",
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
        obj: damage_up, 
        owner: noone
    },
    first_strike_ult:{
        name: "Ultimate: First Strike\n (D-Grade)",
        texture: first_strike_ult,
        chance: 0,
        rarity: "rare",
        pools: ["basic", "ultimate"],
        affinity: "all",
        type: "item",
        gives: [["skill", first_strike]],
        owner: noone
    }
};
room = pre_fight
global.chests_db = {
    basic: {
        name: "basic",
        items: ["hero", "damage_up", "first_strike_ult"]
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