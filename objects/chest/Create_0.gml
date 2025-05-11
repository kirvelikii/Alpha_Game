display_reset(0, true);
// Для GMS 2.3+ (struct):
global.items_db = {
    final_power_up: {
        name: "Final Power UP!",
        texture: final_power_up,
        chance: 0.6,
        rarity: "common",
        pools: ["basic", "stats_up"],
        affinity: "all"
    },
    damage_up: {
        name: "Damage UP!",
        texture: damage_up,
        chance: 0.005,
        rarity: "legendary",
        pools: ["basic", "stats_up"],
        affinity: "all"
    },
    first_strike_ult:{
        name: "Ultimate: First Strike\n (D-Grade)",
        texture: first_strike_ult,
        chance: 0.2,
        rarity: "rare",
        pools: ["basic", "ultimate"],
        affinity: "all"
    }
};

global.chests_db = {
    basic: {
        name: "basic",
        items: ["final_power_up", "damage_up", "first_strike_ult"]
    }
};
rolling = 0
col = c_black
rolling_items = []
time = 30
drop = noone
chestt = "basic"
s = noone
sspeed = random_range(25, 30)
a = random_range(-0.07, -0.05)
new_r = (room_width + 128 / sspeed)