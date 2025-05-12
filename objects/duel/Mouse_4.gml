global.count_wins = [0, 0]
draw_set_color(c_black); // Черный (стандартный)
draw_set_alpha(1); // Полная непрозрачность

// Выравнивание
draw_set_halign(fa_left); // По левому краю (по умолчанию)
draw_set_valign(fa_top); // По верхнему краю (по умолчанию)

// Шрифт
draw_set_font(-1);
//global.chars = [["starter", "starter", "starter"], ["starter", "starter", "starter"]]
global.loot = [[], []]
global.lootobj = [[], []]
global.equips = [[], []]
global.ai = false
global.mode = "duel"
global.teams = [3, 3]
room = draft