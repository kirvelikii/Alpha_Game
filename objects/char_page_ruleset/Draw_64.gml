draw_sprite(avatarr, 1 ,75, 100)
draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_set_font(fnt_focus) 
draw_text_color(130, 250, data.variables.name, c_white, c_white, c_white, c_white, 1)
draw_sprite(hp_icon, 1, 50, 300)
draw_text_color(100, 300, data.variables.max_hp, c_white, c_white, c_white, c_white, 1)
draw_sprite(atk_icon, 1, 150, 300)
draw_text_color(200, 300, data.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
draw_sprite(rang_icon, 1, 50, 348)
draw_text_color(100, 348, data.variables.basic_range, c_white, c_white, c_white, c_white, 1)
draw_sprite(atk_speed_icon, 1, 150, 348)
draw_text_color(200, 348, data.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
draw_sprite(accuracy_icon, 1, 50, 396)
draw_text_color(100, 396, data.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
draw_sprite(dodge_icon, 1, 150, 396)
draw_text_color(200, 396, data.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
draw_sprite(crit_chance_icon, 1, 50, 444)
draw_text_color(100, 444, data.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
draw_sprite(crit_damage_icon, 1, 150, 444)
draw_text_color(200, 444, data.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
draw_sprite(speed_icon, 1, 50, 492)
draw_text_color(200, 492, data.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
draw_sprite(sanity_icon, 1, 150, 492)
draw_text_color(100, 492, data.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
var xx = 1660
var yy = 600
var count = array_length(data.variables.skills)
var spacing = 48
for (var i = 0; i < array_length(data.variables.skills); i++) { 
    var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
    var pos_x = xx - offset + (i % 6) * spacing;
    draw_sprite_ext(object_get_sprite(data.variables.skills[i]), 1, pos_x, yy + 48 * floor(i/6), 0.5, 0.5, 0, c_white, 1);
}
if page == "info"{
    draw_text_ext(800, 100, data.variables.lore, -1, 600)
    draw_text(600, 200, "Эффекты морали:")
    var nms = struct_get_names(data.variables.low_sanity_effect)
    for (var i = 0; i < array_length(nms); i++){
        var dt = [nms[i] ,data.variables.low_sanity_effect[$ nms[i]]]
        draw_text(600, 225 + 25 * i, "< " + string_replace(dt[0], "s", "") + " - " + dt[1])
    }
}