if inv_ruleset.team == 1{
if position_meeting(mouse_x, mouse_y, self) and inv_ruleset.drag_obj == noone{
    if mouse_x >= room_width / 2{
        draw_rectangle_color(x - 300, y, x, y + 500, c_black, c_black, c_black, c_black, false)
        draw_rectangle_color(x - 300, y, x, y + 500, c_white, c_white, c_white, c_white, true)
        draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_font(fnt_focus)
        draw_text_color(x - 150, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
        draw_sprite(hp_icon, 1, x - 250, y + 64)
        draw_text_color(x - 200, y + 64, reff.variables.max_hp, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_icon, 1, x - 150, y + 64)
        draw_text_color(x - 100, y + 64, reff.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite(rang_icon, 1, x - 250, y + 112)
        draw_text_color(x - 200, y + 112, reff.variables.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_speed_icon, 1, x - 150, y + 112)
        draw_text_color(x - 100, y + 112, reff.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
        draw_sprite(accuracy_icon, 1, x - 250, y + 160)
        draw_text_color(x - 200, y + 160, reff.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite(dodge_icon, 1, x - 150, y + 160)
        draw_text_color(x - 100, y + 160, reff.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_chance_icon, 1, x - 250, y + 208)
        draw_text_color(x - 200, y + 208, reff.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_damage_icon, 1, x - 150, y + 208)
        draw_text_color(x - 100, y + 208, reff.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
        draw_sprite(speed_icon, 1, x - 250, y + 256)
        draw_text_color(x - 200, y + 256, reff.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
        draw_sprite(sanity_icon, 1, x - 150, y + 256)
        draw_text_color(x - 100, y + 256, reff.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
        var xx = x - 166
        var yy = y + 300
        var count = array_length(reff.variables.skills)
        var spacing = 48
    
        for (var i = 0; i < array_length(reff.variables.skills); i++) { 
        var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        var pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(object_get_sprite(reff.variables.skills[i]), 1, pos_x, yy + 48 * floor(i/6), 0.5, 0.5, 0, c_white, 1);
    }
    }
    else{
        draw_rectangle_color(x + 128, y, x + 428, y + 500, c_black, c_black, c_black, c_black, false)
        draw_rectangle_color(x + 128, y, x + 428, y + 500, c_white, c_white, c_white, c_white, true)
        draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_font(fnt_focus)
        draw_text_color(x+128 + 150, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
        draw_sprite(hp_icon, 1, x+128 + 50, y + 64)
        draw_text_color(x+128 + 100, y + 64, reff.variables.max_hp, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_icon, 1, x+128 + 150, y + 64)
        draw_text_color(x+128 + 200, y + 64, reff.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite(rang_icon, 1, x+128 + 50, y + 112)
        draw_text_color(x+128 + 100, y + 112, reff.variables.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_speed_icon, 1, x+128 + 150, y + 112)
        draw_text_color(x+128 + 200, y + 112, reff.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
        draw_sprite(accuracy_icon, 1, x+128 + 50, y + 160)
        draw_text_color(x+128 + 100, y + 160, reff.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite(dodge_icon, 1, x+128 + 150, y + 160)
        draw_text_color(x+128 + 200, y + 160, reff.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_chance_icon, 1, x+128 + 50, y + 208)
        draw_text_color(x+128 + 100, y + 208, reff.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_damage_icon, 1, x+128 + 150, y + 208)
        draw_text_color(x+128 + 200, y + 208, reff.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
        draw_sprite(speed_icon, 1, x+128 + 50, y + 256)
        draw_text_color(x+128 + 100, y + 256, reff.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
        draw_sprite(sanity_icon, 1, x+128 + 150, y + 256)
        draw_text_color(x+128 + 200, y + 256, reff.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
        var xx = x+128 + 134
        var yy = y + 300
        var count = array_length(reff.variables.skills)
        var spacing = 48
    
        for (var i = 0; i < array_length(reff.variables.skills); i++) { 
        var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        var pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(object_get_sprite(reff.variables.skills[i]), 1, pos_x, yy + 48 * floor(i/6), 0.5, 0.5, 0, c_white, 1);
    }
}
}}
else{
    if position_meeting(mouse_x, mouse_y, self) and inv_ruleset.drag_obj == noone{
    if mouse_x >= room_width / 2{
        draw_rectangle_color(x-128 - 300, y, x-128, y + 500, c_black, c_black, c_black, c_black, false)
        draw_rectangle_color(x-128 - 300, y, x-128, y + 500, c_white, c_white, c_white, c_white, true)
        draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_font(fnt_focus)
        draw_text_color(x-128 - 150, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
        draw_sprite(hp_icon, 1, x-128 - 250, y + 64)
        draw_text_color(x-128 - 200, y + 64, reff.variables.hp, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_icon, 1, x-128 - 150, y + 64)
        draw_text_color(x-128 - 100, y + 64, reff.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite(rang_icon, 1, x-128 - 250, y + 112)
        draw_text_color(x-128 - 200, y + 112, reff.variables.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_speed_icon, 1, x-128 - 150, y + 112)
        draw_text_color(x-128 - 100, y + 112, reff.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
        draw_sprite(accuracy_icon, 1, x-128 - 250, y + 160)
        draw_text_color(x-128 - 200, y + 160, reff.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite(dodge_icon, 1, x-128 - 150, y + 160)
        draw_text_color(x-128 - 100, y + 160, reff.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_chance_icon, 1, x-128 - 250, y + 208)
        draw_text_color(x-128 - 200, y + 208, reff.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_damage_icon, 1, x-128 - 150, y + 208)
        draw_text_color(x-128 - 100, y + 208, reff.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
        draw_sprite(speed_icon, 1, x-128 - 250, y + 256)
        draw_text_color(x-128 - 200, y + 256, reff.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
        draw_sprite(sanity_icon, 1, x-128 - 150, y + 256)
        draw_text_color(x-128 - 100, y + 256, reff.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
        var xx = x-128 - 166
        var yy = y + 300
        var count = array_length(reff.variables.skills)
        var spacing = 48
    
        for (var i = 0; i < array_length(reff.variables.skills); i++) { 
        var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        var pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(object_get_sprite(reff.variables.skills[i]), 1, pos_x, yy + 48 * floor(i/6), 0.5, 0.5, 0, c_white, 1);
    }
    }
    else{
        draw_rectangle_color(x, y, x + 300, y + 500, c_black, c_black, c_black, c_black, false)
        draw_rectangle_color(x, y, x + 300, y + 500, c_white, c_white, c_white, c_white, true)
        draw_set_halign(fa_center)
        draw_set_valign(fa_top)
        draw_set_font(fnt_focus)
        draw_text_color(x + 150, y + 16, reff.variables.name, c_white, c_white, c_white, c_white, 1)
        draw_sprite(hp_icon, 1, x + 50, y + 64)
        draw_text_color(x + 100, y + 64, reff.variables.hp, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_icon, 1, x + 150, y + 64)
        draw_text_color(x + 200, y + 64, reff.variables.basic_attack, c_white, c_white, c_white, c_white, 1)
        draw_sprite(rang_icon, 1, x + 50, y + 112)
        draw_text_color(x + 100, y + 112, reff.variables.basic_range, c_white, c_white, c_white, c_white, 1)
        draw_sprite(atk_speed_icon, 1, x + 150, y + 112)
        draw_text_color(x + 200, y + 112, reff.variables.attack_interval / 60, c_white, c_white, c_white, c_white, 1)
        draw_sprite(accuracy_icon, 1, x + 50, y + 160)
        draw_text_color(x + 100, y + 160, reff.variables.basic_accuracy, c_white, c_white, c_white, c_white, 1)
        draw_sprite(dodge_icon, 1, x + 150, y + 160)
        draw_text_color(x + 200, y + 160, reff.variables.dodge_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_chance_icon, 1, x + 50, y + 208)
        draw_text_color(x + 100, y + 208, reff.variables.basic_crit_chance, c_white, c_white, c_white, c_white, 1)
        draw_sprite(crit_damage_icon, 1, x + 150, y + 208)
        draw_text_color(x + 200, y + 208, reff.variables.basic_crit_damage, c_white, c_white, c_white, c_white, 1)
        draw_sprite(speed_icon, 1, x + 50, y + 256)
        draw_text_color(x + 100, y + 256, reff.variables.mov_speed, c_white, c_white, c_white, c_white, 1)
        draw_sprite(sanity_icon, 1, x + 150, y + 256)
        draw_text_color(x + 200, y + 256, reff.variables.max_sanity, c_white, c_white, c_white, c_white, 1)
        var xx = x + 134
        var yy = y + 300
        var count = array_length(reff.variables.skills)
        var spacing = 48
    
        for (var i = 0; i < array_length(reff.variables.skills); i++) { 
        var offset = spacing * min((count - 1 - floor(i/6) * 6), 5) * 0.5;
        var pos_x = xx - offset + (i % 6) * spacing;
        draw_sprite_ext(object_get_sprite(reff.variables.skills[i]), 1, pos_x, yy + 48 * floor(i/6), 0.5, 0.5, 0, c_white, 1);
    }
    }
    }
}