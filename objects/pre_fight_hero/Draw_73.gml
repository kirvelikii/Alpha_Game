if position_meeting(mouse_x, mouse_y, self) and inv_ruleset.drag_obj == noone{
    if mouse_x >= room_width / 2{
        draw_rectangle_color(x - 300 - (1-image_xscale) / 2 * 128, y, x - (1-image_xscale) / 2 * 128, y + 500, c_black, c_black, c_black, c_black, false)
        draw_rectangle_color(x - 300 - (1-image_xscale) / 2 * 128, y, x - (1-image_xscale) / 2 * 128, y + 500, c_white, c_white, c_white, c_white, true)
        draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_font(fnt_focus)
        draw_text_color(x - 150 - (1-image_xscale) / 2 * 128, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
        draw_sprite(hp_icon, 1, x - 250 - (1-image_xscale) / 2 * 128, y + 64)
        draw_set_halign(fa_left)
        draw_text_color(x - 200 - (1-image_xscale) / 2 * 128, y + 64, reff.variables.max_hp, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_icon, 1, x - 150 - (1-image_xscale) / 2 * 128, y + 64)
        draw_text_color(x - 100 - (1-image_xscale) / 2 * 128, y + 64, reff.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite(rang_icon, 1, x - 250 - (1-image_xscale) / 2 * 128, y + 112)
        draw_text_color(x - 200 - (1-image_xscale) / 2 * 128, y + 112, reff.variables.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_speed_icon, 1, x - 150 - (1-image_xscale) / 2 * 128, y + 112)
        draw_text_color(x - 100 - (1-image_xscale) / 2 * 128, y + 112, reff.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
        draw_sprite(accuracy_icon, 1, x - 250 - (1-image_xscale) / 2 * 128, y + 160)
        draw_text_color(x - 200 - (1-image_xscale) / 2 * 128, y + 160, reff.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite(dodge_icon, 1, x - 150 - (1-image_xscale) / 2 * 128, y + 160)
        draw_text_color(x - 100 - (1-image_xscale) / 2 * 128, y + 160, reff.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_chance_icon, 1, x - 250 - (1-image_xscale) / 2 * 128, y + 208)
        draw_text_color(x - 200 - (1-image_xscale) / 2 * 128, y + 208, reff.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_damage_icon, 1, x - 150 - (1-image_xscale) / 2 * 128, y + 208)
        draw_text_color(x - 100 - (1-image_xscale) / 2 * 128, y + 208, reff.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
        draw_sprite(speed_icon, 1, x - 250 - (1-image_xscale) / 2 * 128, y + 256)
        draw_text_color(x - 200 - (1-image_xscale) / 2 * 128, y + 256, reff.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
        draw_sprite(sanity_icon, 1, x - 150 - (1-image_xscale) / 2 * 128, y + 256)
        draw_text_color(x - 100 - (1-image_xscale) / 2 * 128, y + 256, reff.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
        var xx = x - 166 - (1-image_xscale) / 2 * 128
        var yy = y + 300
        var count = array_length(reff.variables.skills)
        var spacing = 48
    
        for (var i = 0; i < array_length(reff.variables.skills); i++) { 
        var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        var pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(object_get_sprite(reff.variables.skills[i].object_index), 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1);
        }
        var yy = y + 375
        count = array_length(reff.variables.equips)
    
        for (var i = 0; i < array_length(reff.variables.equips); i++) { 
        offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(reff.variables.equips[i].texture, 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1);    
    }
    }
    else{
        draw_rectangle_color(x + 128 - (1-image_xscale) / 2 * 128, y, x + 428 - (1-image_xscale) / 2 * 128, y + 500, c_black, c_black, c_black, c_black, false)
        draw_rectangle_color(x + 128 - (1-image_xscale) / 2 * 128, y, x + 428 - (1-image_xscale) / 2 * 128, y + 500, c_white, c_white, c_white, c_white, true)
        draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_font(fnt_focus)
        draw_text_color(x+128 + 150 - (1-image_xscale) / 2 * 128, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
        draw_sprite(hp_icon, 1, x+128 + 50 - (1-image_xscale) / 2 * 128, y + 64)
        draw_set_halign(fa_left)
        draw_text_color(x+128 + 100 - (1-image_xscale) / 2 * 128, y + 64, reff.variables.max_hp, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_icon, 1, x+128 + 150 - (1-image_xscale) / 2 * 128, y + 64)
        draw_text_color(x+128 + 200 - (1-image_xscale) / 2 * 128, y + 64, reff.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite(rang_icon, 1, x+128 + 50 - (1-image_xscale) / 2 * 128, y + 112)
        draw_text_color(x+128 + 100 - (1-image_xscale) / 2 * 128, y + 112, reff.variables.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_speed_icon, 1, x+128 + 150 - (1-image_xscale) / 2 * 128, y + 112)
        draw_text_color(x+128 + 200 - (1-image_xscale) / 2 * 128, y + 112, reff.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
        draw_sprite(accuracy_icon, 1, x+128 + 50 - (1-image_xscale) / 2 * 128, y + 160)
        draw_text_color(x+128 + 100 - (1-image_xscale) / 2 * 128, y + 160, reff.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite(dodge_icon, 1, x+128 + 150 - (1-image_xscale) / 2 * 128, y + 160)
        draw_text_color(x+128 + 200 - (1-image_xscale) / 2 * 128, y + 160, reff.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_chance_icon, 1, x+128 + 50 - (1-image_xscale) / 2 * 128, y + 208)
        draw_text_color(x+128 + 100 - (1-image_xscale) / 2 * 128, y + 208, reff.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_damage_icon, 1, x+128 + 150 - (1-image_xscale) / 2 * 128, y + 208)
        draw_text_color(x+128 + 200 - (1-image_xscale) / 2 * 128, y + 208, reff.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
        draw_sprite(speed_icon, 1, x+128 + 50 - (1-image_xscale) / 2 * 128, y + 256)
        draw_text_color(x+128 + 100 - (1-image_xscale) / 2 * 128, y + 256, reff.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
        draw_sprite(sanity_icon, 1, x+128 + 150 - (1-image_xscale) / 2 * 128, y + 256)
        draw_text_color(x+128 + 200 - (1-image_xscale) / 2 * 128, y + 256, reff.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
        var xx = x+128 + 134 - (1-image_xscale) / 2 * 128
        var yy = y + 300
        var count = array_length(reff.variables.skills)
        var spacing = 48
    
        for (var i = 0; i < array_length(reff.variables.skills); i++) { 
        var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        var pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(object_get_sprite(reff.variables.skills[i].object_index), 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1);
    }
        yy = y + 375
            count = array_length(reff.variables.equips)
    
            for (var i = 0; i < array_length(reff.variables.equips); i++) { 
            var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
            var pos_x = xx - offset + (i % 6) * spacing;
            draw_sprite_ext(reff.variables.equips[i].texture, 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1); }
}
}
 if position_meeting(mouse_x, mouse_y, self) and inv_ruleset.drag_obj != noone and inv_ruleset.drag_obj.type == item {
        if mouse_x >= room_width / 2 {
            // ЛЕВАЯ ПАНЕЛЬ (команда 1)
            draw_rectangle_color(x - 300, y, x, y + 500, c_black, c_black, c_black, c_black, false)
            draw_rectangle_color(x - 300, y, x, y + 500, c_white, c_white, c_white, c_white, true)
            
            // Заголовок
            draw_set_halign(fa_center)
            draw_set_valign(fa_top)
            draw_set_font(fnt_focus)
            draw_text_color(x - 150, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
            
            // Функция для отрисовки стата с изменениями
            function draw_stat_with_change(_x, _y, icon, value, stat_name) {
                draw_sprite(icon, 1, _x, _y)
                var text = string(value)
                var text_color = c_white
                //show_message(value * inv_ruleset.drag_obj.stats_shown[$ (stat_name + "_perc")] )
                var stat_change = (real(inv_ruleset.drag_obj.stats_shown[$ stat_name])) * (1 + real(inv_ruleset.drag_obj.stats_shown[$ (stat_name + "_perc")]) + reff.variables.modifer[$ stat_name]) + value / (1 + reff.variables.modifer[$ stat_name]) * (1 + real(inv_ruleset.drag_obj.stats_shown[$ (stat_name + "_perc")]) + reff.variables.modifer[$ stat_name]) - value 
                if !is_undefined(stat_change) && stat_change != 0 {
                    var change_val = real(stat_change)
                    var change_str = (change_val >= 0 ? "+" : "") + string(stat_change)
                    text += " " + change_str
                    if stat_name != "attack_interval" and stat_name != "attack_interval_perc"{
                        text_color = (change_val >= 0) ? c_green : c_red
                    }
                    else{
                        text_color = (change_val >= 0) ? c_red : c_green
                    }
                }
                draw_set_halign(fa_left)
                draw_text_color(_x + 32, _y, text, c_white, c_white, text_color, text_color, 1)
            }
            
            // Статы (первый столбец)
            draw_stat_with_change(x - 250, y + 64, hp_icon, reff.variables.max_hp, "max_hp")
            draw_stat_with_change(x - 250, y + 112, rang_icon, reff.variables.basic_range, "basic_range")
            draw_stat_with_change(x - 250, y + 160, accuracy_icon, reff.variables.basic_accuracy, "basic_accuracy")
            draw_stat_with_change(x - 250, y + 208, crit_chance_icon, reff.variables.basic_crit_chance, "basic_crit_chance")
            draw_stat_with_change(x - 250, y + 256, speed_icon, reff.variables.mov_speed, "mov_speed")
            
            // Статы (второй столбец)
            draw_stat_with_change(x - 150, y + 64, atk_icon, reff.variables.basic_attack, "basic_attack")
            draw_stat_with_change(x - 150, y + 112, atk_speed_icon, reff.variables.attack_interval / 60, "attack_interval")
            draw_stat_with_change(x - 150, y + 160, dodge_icon, reff.variables.dodge_chance, "dodge_chance")
            draw_stat_with_change(x - 150, y + 208, crit_damage_icon, reff.variables.basic_crit_damage, "basic_crit_damage")
            draw_stat_with_change(x - 150, y + 256, sanity_icon, reff.variables.max_sanity, "max_sanity")
            
            // Скиллы
            var xx = x - 166
            var yy = y + 300
            var count = array_length(reff.variables.skills)
            var spacing = 48
        
            for (var i = 0; i < array_length(reff.variables.skills); i++) { 
                var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5
                var pos_x = xx - offset + (i % 6) * spacing
                draw_sprite_ext(object_get_sprite(reff.variables.skills[i].object_index), 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1)
            }
            
            yy = y + 375
            count = array_length(reff.variables.equips)
    
            for (var i = 0; i < array_length(reff.variables.equips); i++) { 
            var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
            var pos_x = xx - offset + (i % 6) * spacing;
            draw_sprite_ext(reff.variables.equips[i].texture, 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1); }
        }
        else {
            // ПРАВАЯ ПАНЕЛЬ (команда 1)
            draw_rectangle_color(x + 128, y, x + 428, y + 500, c_black, c_black, c_black, c_black, false)
            draw_rectangle_color(x + 128, y, x + 428, y + 500, c_white, c_white, c_white, c_white, true)
            
            // Заголовок
            draw_set_halign(fa_center)
            draw_set_valign(fa_top)
            draw_set_font(fnt_focus)
            draw_text_color(x + 128 + 150, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
            
            // Статы (первый столбец)
            draw_stat_with_change(x + 128 + 50, y + 64, hp_icon, reff.variables.max_hp, "max_hp")
            draw_stat_with_change(x + 128 + 50, y + 112, rang_icon, reff.variables.basic_range, "basic_range")
            draw_stat_with_change(x + 128 + 50, y + 160, accuracy_icon, reff.variables.basic_accuracy, "basic_accuracy")
            draw_stat_with_change(x + 128 + 50, y + 208, crit_chance_icon, reff.variables.basic_crit_chance, "basic_crit_chance")
            draw_stat_with_change(x + 128 + 50, y + 256, speed_icon, reff.variables.mov_speed, "mov_speed")
            
            // Статы (второй столбец)
            draw_stat_with_change(x + 128 + 150, y + 64, atk_icon, reff.variables.basic_attack, "basic_attack")
            draw_stat_with_change(x + 128 + 150, y + 112, atk_speed_icon, reff.variables.attack_interval / 60, "attack_interval")
            draw_stat_with_change(x + 128 + 150, y + 160, dodge_icon, reff.variables.dodge_chance, "dodge_chance")
            draw_stat_with_change(x + 128 + 150, y + 208, crit_damage_icon, reff.variables.basic_crit_damage, "basic_crit_damage")
            draw_stat_with_change(x + 128 + 150, y + 256, sanity_icon, reff.variables.max_sanity, "max_sanity")
            
            // Скиллы
            var xx = x + 128 + 134
            var yy = y + 300
            var count = array_length(reff.variables.skills)
            var spacing = 48
        
            for (var i = 0; i < array_length(reff.variables.skills); i++) { 
                var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5
                var pos_x = xx - offset + (i % 6) * spacing
                draw_sprite_ext(object_get_sprite(reff.variables.skills[i].object_index), 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1)
            }
            yy = y + 375
            count = array_length(reff.variables.equips)
    
            for (var i = 0; i < array_length(reff.variables.equips); i++) { 
            var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
            var pos_x = xx - offset + (i % 6) * spacing;
            draw_sprite_ext(reff.variables.equips[i].texture, 1, pos_x, yy + 48 * floor(i/6), 0.25, 0.25, 0, c_white, 1); }
        }
    }