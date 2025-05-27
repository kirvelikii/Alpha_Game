draw_set_font(fnt_result)
draw_set_halign(fa_center)
draw_text_color(room_width / 2, 50, ":", c_white, c_white, c_white, c_white, 1)
draw_text_color(room_width / 2 - 25, 50, schet[0], c_red, c_red, c_red, c_red, 1)
draw_text_color(room_width / 2 + 25, 50, schet[1], c_blue, c_blue, c_blue, c_blue, 1)
if opened{
draw_rectangle_color(0, 800, 2049, 1152, c_black, c_black, c_black, c_black, 0) 
draw_set_font(fnt_focus)
//draw_text(350, 800, "Убийств        Смертей          Помощи         Урон        Полученный      Полученный        Урон         Убийств        Смертей          Помощи")
if global.chosen_pers == noone{
    draw_set_halign(fa_center)
    draw_set_valign(fa_top)
    var posl = ["Убийств", "Смертей", "Помощи", "Нанесенный урон", "Полученный урон", "Полученный урон", "Нанесенный урон", "Помощи", "Смертей", "Убийств"]
    for (var ry = 0; ry < 10; ry++){
        draw_line(250 + 150 * ry, 800, 250 + 150 * ry, 1152)
        draw_text_ext(250 + 150 * ry + 75, 800, posl[ry], -1, 100)
    }
    draw_line(250 + 150 * 10, 800, 250 + 150 * 10, 1152)
    var poss = ["kills", "deaths", "assists", "damage", "damage_taken"]
    for (var i = 0; i < min(4, array_length(tops1)); i++){
        draw_set_halign(fa_left)
        draw_set_valign(fa_top)
        if instance_exists(tops1[i][0]){
            draw_sprite_ext((tops1[i][0].sprite_index), 1, 50, 832 + 64 * i, 0.5, 0.5, 0, c_white, 1)
            tops1[i][0].draw_my_healthbar(50, 50-10, 832 + 64 * (i), 832 + 64 * (i + 1), 64)
        }
        else{
            draw_sprite_ext((tops1[i][0].sprite_index), 1, 50, 832 + 64 * i, 0.5, 0.5, 0, c_red, 1)
        }
        draw_text(150, 832 + 16 + 64 * i, string(tops1[i][1]) + " " + tops1[i][0].name)
        draw_set_halign(fa_center)
        draw_set_valign(fa_middle)
        for (var t = 0; t < 5; t++){
            if t<=2{
                draw_text(250 + 150 * t + 75, 832 + 64 * i + 32, tops1[i][0].statistics.kda_last[$ poss[t]])
            }
            else{
                draw_text(250 + 150 * t + 75, 832 + 64 * i + 32, tops1[i][0].statistics[$ poss[t]].last)
            }

        }
    }
    for (var i = 0; i < min(4, array_length(tops2)); i++){
        draw_set_halign(fa_right)
        draw_set_valign(fa_top)
        if instance_exists(tops2[i][0]){
            draw_sprite_ext((tops2[i][0].sprite_index), 1, 1999, 832 + 64 * i, -0.5, 0.5, 0, c_white, 1)
            tops2[i][0].draw_my_healthbar(1999, 1999+10, 832 + 64 * (i), 832 + 64 * (i + 1), 64)
        }
        else{
            draw_sprite_ext((tops2[i][0].sprite_index), 1, 1999, 832 + 64 * i, -0.5, 0.5, 0, c_red, 1)
        }
        draw_text(1899, 832 + 16 + 64 * i, tops2[i][0].name + " " + string(tops1[i][1]))
        draw_set_halign(fa_center)
        draw_set_valign(fa_middle)
        for (var t = 0; t < 5; t++){
            if t<=2{
                draw_text(1799 - 150 * t - 125, 832 + 64 * i + 32, tops2[i][0].statistics.kda_last[$ poss[t]])
            }
            else{
                draw_text(1799 - 150 * t - 125, 832 + 64 * i + 32, tops2[i][0].statistics[$ poss[t]].last)
            }

        }
    }
} else{
    if instance_exists(global.chosen_pers){
        (draw_sprite(global.chosen_pers.sprite_index, 1, 100, 850))
        draw_horizontal_healthbar(300, 1200, 900, 925, 900)
        draw_horizontal_sanitybar(300, 1200, 935, 960, 900)
        var xx = 750 - 32
        var yy = 1000
        var count = array_length(global.chosen_pers.skills)
        var spacing = 74
        for (var i = 0; i < array_length(global.chosen_pers.skills); i++) { 
            var offset = spacing * min((count - 1 - floor(i/10) * 10), 5) * 0.5
            var pos_x = xx - offset + (i % 10) * spacing
            draw_sprite_ext(object_get_sprite(global.chosen_pers.skills[i].object_index), 1, pos_x, yy + 48 * floor(i/10), 0.5, 0.5, 0, c_white, 1) 
            if (!global.chosen_pers.skills_ins[i].ready) {
            var progress = 1 - (global.chosen_pers.skills_ins[i].cd / global.chosen_pers.skills_ins[i].cooldown);
            global.chosen_pers.skills_ins[i].draw_skill_cooldown(pos_x, yy + 48 * floor(i/10), global.chosen_pers.skills_ins[i].icon_size, progress, c_black);
                }
            if (!global.chosen_pers.skills_ins[i].ready) {
            var seconds = ceil(global.chosen_pers.skills_ins[i].cd / 60);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text_color(pos_x + global.chosen_pers.skills_ins[i].icon_size/2, yy + 48 * floor(i/10) + global.chosen_pers.skills_ins[i].icon_size/2, string(seconds), c_black, c_black, c_black, c_black, 1);
            }
            }}
    else{
        draw_sprite_ext(global.chosen_pers.sprite_index, 1, 100, 850, 1, 1, 0, c_red, 1) 
        var xx = 750 - 32
        var yy = 1000
        var count = array_length(global.chosen_pers.skills)
        var spacing = 74
        for (var i = 0; i < array_length(global.chosen_pers.skills); i++) { 
            var offset = spacing * min((count - 1 - floor(i/10) * 10), 5) * 0.5
            var pos_x = xx - offset + (i % 10) * spacing
            draw_sprite_ext(object_get_sprite(global.chosen_pers.skills[i].object_index), 1, pos_x, yy + 48 * floor(i/10), 0.5, 0.5, 0, c_white, 1)}
    }
    draw_set_valign(fa_top);
    draw_set_halign(fa_center)
    draw_set_font(fnt_result)
    draw_text(750, 900, string(global.chosen_pers.hp) + "/" + string(global.chosen_pers.max_hp))
    draw_text(750, 935, string(global.chosen_pers.sanity) + "/" + string(global.chosen_pers.max_sanity)) 
    draw_text(750, 820, global.chosen_pers.name)
    var st = ""
    switch global.chosen_pers.state{
        case "retreat" : st = "Отступает" break
        case "panic" : st = "Бежит" break
        case "crazy" : st = "Сошел с ума" break
        default: st = "В порядке" break
            
     }   
    draw_text(750, 860, st)
    draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_halign(fa_left)
        draw_sprite_ext(atk_icon, 1, 1300, 850, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1400, 850, global.chosen_pers.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite_ext(atk_speed_icon, 1, 1500, 850, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1600, 850, global.chosen_pers.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
    
        draw_text_color(1400, 900, global.chosen_pers.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite_ext(rang_icon, 1, 1300, 900, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1600, 900, global.chosen_pers.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite_ext(accuracy_icon, 1, 1500, 900, 1.5, 1.5, 0, c_white, 1)
    
        draw_sprite_ext(crit_chance_icon, 1, 1300, 950, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1400, 950, global.chosen_pers.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite_ext(crit_damage_icon, 1, 1500, 950, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1600, 950, global.chosen_pers.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
    
        draw_sprite_ext(dodge_icon, 1, 1300, 1000, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1400, 1000, global.chosen_pers.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite_ext(speed_icon, 1, 1500, 1000, 1.5, 1.5, 0, c_white, 1)
        draw_text_color(1600, 1000, global.chosen_pers.mov_speed, c_white, c_white, c_white, c_white, 1)
    
    
    for (var h = 0; h < array_length(global.chosen_pers.statuses_visual); h++){
        //show_message(global.chosen_pers.statuses_visual[h])
        draw_sprite_ext(object_get_sprite(global.chosen_pers.statuses_visual[h].type), 1, 35 + 50 * h, 985 + floor(h/5), 1.5, 1.5, 0, c_white, 1)
        draw_set_valign(fa_middle)
        draw_set_halign(fa_center)
        if global.chosen_pers.statuses_visual[h].drawn_stat != ""{
            draw_text(35 + 50 * h + 24, 985 + floor(h/5) + 24, global.chosen_pers.statuses_visual[h][$ global.chosen_pers.statuses_visual[h].drawn_stat])
        }
        
    }
    for (var h = 0; h < array_length(global.chosen_pers.equips); h++){
        //show_message(global.chosen_pers.equips[h])
        draw_sprite_ext(global.chosen_pers.equips[h].texture, 1, 1700 + 80 * h, 832 + floor(h/4), 0.5, 0.5, 0, c_white, 1)
        
    }
    }
} 
draw_set_halign(fa_left)
draw_set_valign(fa_top)