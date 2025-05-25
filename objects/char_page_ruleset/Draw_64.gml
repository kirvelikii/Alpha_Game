gpu_set_scissor(0, 0, 1366, 769);
draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_text_color(130, 250, data.variables.name, c_white, c_white, c_white, c_white, 1)
draw_sprite(avatarr, 1 ,75, 100)
if !position_meeting(mouse_x, mouse_y, obj_focus_block) or collision_point(mouse_x, mouse_y, obj_focus_block, false, false).focus_unlocked{ 
draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_set_font(fnt_focus) 
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
draw_text_color(100, 492, data.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
draw_sprite(sanity_icon, 1, 150, 492)
draw_text_color(200, 492, data.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
}
else{
    var rew = collision_point(mouse_x, mouse_y, obj_focus_block, false, false)
            draw_stat_with_change(100 - 50, 300, hp_icon, data.variables.max_hp, "max_hp")
            draw_stat_with_change(100 - 50, 348, rang_icon, data.variables.basic_range, "basic_range")
            draw_stat_with_change(100 - 50, 396, accuracy_icon, data.variables.basic_accuracy, "basic_accuracy")
            draw_stat_with_change(100 - 50, 444, crit_chance_icon, data.variables.basic_crit_chance, "basic_crit_chance")
            draw_stat_with_change(100 - 50, 492, speed_icon, data.variables.mov_speed, "mov_speed")
            
            // Статы (второй столбец)
            draw_stat_with_change(200 - 50, 300, atk_icon, data.variables.basic_attack, "basic_attack")
            draw_stat_with_change(200 - 50, 348, atk_speed_icon, data.variables.attack_interval / 60, "attack_interval")
            draw_stat_with_change(200 - 50, 396, dodge_icon, data.variables.dodge_chance, "dodge_chance")
            draw_stat_with_change(200 - 50, 444, crit_damage_icon, data.variables.basic_crit_damage, "basic_crit_damage")
            draw_stat_with_change(200 - 50, 492, sanity_icon, data.variables.max_sanity, "max_sanity")
}
if page == "info"{
    draw_text_ext(700, 100, data.variables.lore, -1, 600)
    draw_text(375, 200, "Эффекты морали:")
    var nms = struct_get_names(data.variables.low_sanity_effect)
    for (var i = 0; i < array_length(nms); i++){
        var dt = [nms[i] ,data.variables.low_sanity_effect[$ nms[i]]]
        draw_text(375, 225 + 25 * i, "< " + string_replace(dt[0], "s", "") + " - " + dt[1])
    }
    var nns = struct_get_names(data.variables.statistics)
    var kd = 0
    for (var r = 0; r < array_length(nns); r++){
        if nns[r] == "damage"{
            draw_text(1100, 200 + 100 * (r - kd), "Всего урона: " + string(data.variables.statistics[$ nns[r]].total))
            draw_text(1100, 200 + 100 * (r - kd) + 25, "Рекорд урона за раунд: " + string(data.variables.statistics[$ nns[r]].record))
            draw_text(1100, 200 + 100 * (r - kd) + 50, "Урон за последний раунд: " + string(data.variables.statistics[$ nns[r]].last))
        }
        else if nns[r] == "damage_taken"{
            draw_text(1100, 200 + 100 * (r - kd), "Всего урона получено: " + string(data.variables.statistics[$ nns[r]].total))
            draw_text(1100, 200 + 100 * (r - kd) + 25, "Рекорд полученного урона за раунд: " + string(data.variables.statistics[$ nns[r]].record))
            draw_text(1100, 200 + 100 * (r - kd) + 50, "Полученный урон за последний раунд: " + string(data.variables.statistics[$ nns[r]].last))
        }
        else if nns[r] == "kda_last"{
            draw_text(700, 200 + 100 * kd, "Убийств за последний раунд: " + string(data.variables.statistics[$ nns[r]].kills))
            draw_text(700, 200 + 100 * kd + 25, "Смертей за последний раунд: " + string(data.variables.statistics[$ nns[r]].deaths))
            draw_text(700, 200 + 100 * kd + 50, "Помощи за последний раунд: " + string(data.variables.statistics[$ nns[r]].assists))
            kd += 1
        }
        else if nns[r] == "kda_record"{
            draw_text(700, 200 + 100 * kd, "Максимум убийств: " + string(data.variables.statistics[$ nns[r]].kills))
            draw_text(700, 200 + 100 * kd + 25, "Максимум смертей: " + string(data.variables.statistics[$ nns[r]].deaths))
            draw_text(700, 200 + 100 * kd + 50, "Максимум помощи: " + string(data.variables.statistics[$ nns[r]].assists))
            kd += 1
        }
        else if nns[r] == "kda_total"{
            draw_text(700, 200 + 100 * kd, "Всего убийств: " + string(data.variables.statistics[$ nns[r]].kills))
            draw_text(700, 200 + 100 * kd + 25, "Всего смертей: " + string(data.variables.statistics[$ nns[r]].deaths))
            draw_text(700, 200 + 100 * kd + 50, "Всего помощи: " + string(data.variables.statistics[$ nns[r]].assists))
            kd += 1
        }
    }
}