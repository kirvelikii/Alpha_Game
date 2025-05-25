if position_meeting(mouse_x, mouse_y, self){
    
    draw_sprite(vsp_s, 1, 966, 0)
    //draw_sprite_ext(Sprite18, 1, 0, 0, 0.5, 0.5, 0, c_white, 0.3)
    draw_set_halign(-1)
    draw_set_valign(-1)
    draw_sprite(focus_icon, 1, 1016-20, 20)
    draw_set_halign(fa_center)
    draw_text(1366-200, 50, focus_name)
    draw_text_ext(1366-200, 100, focus_description, -1, 400)
    draw_text(1366-200, 175, "Цена: " + string(focus_cost))
    if !focus_unlocked and can_unlock(){ 
        draw_set_halign(fa_left)
        draw_text_color(1366-10, 700, "-" + string(focus_cost), c_red, c_white, c_red, c_red, 1)
        draw_set_halign(fa_center)
    }
    //draw_text(1366-200, 200, "Требования:")
    len = 1
    le = 0
    draw_focus_requirements(1366-200, 200, focus_restrictions)
    /*for (var i = 0; i<array_length(focus_restrictions); i++ ){
        if i != 0{draw_text(1366-200, 200 + 25 * len + le, "Или"); len+=1}
        for (var j = 0; j < array_length(focus_restrictions[i]); j++){
            if !string_starts_with(focus_restrictions[i][j], "!"){
                if string_starts_with(focus_restrictions[i][j], "f"){
                    //show_message(focus_restrictions[i][j])
                    var fcs = "Undefined"
                    var cl = c_red
                    var need = string_copy(focus_restrictions[i][j], 2, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            fcs = focus_name
                            if focus_unlocked{
                                cl = c_lime
                            }
                        }
                    }
                    draw_text_ext_color(1366-200, 200 + 25 * len + le, "Должен быть изучен фокус " + "'" + fcs + "'", -1, 400, cl, cl, cl, cl, 1)
                    len+=1
                    le += string_height_ext("Должен быть изучен фокус " + "'" + fcs + "'", -1, 400) - 25
                }
            }
            else{
                if string_starts_with(focus_restrictions[i][j], "!f"){
                    //show_message(focus_restrictions[i][j])
                    var fcs = "Undefined"
                    var c1 = c_lime
                    var need = string_copy(focus_restrictions[i][j], 3, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            fcs = focus_name
                            if focus_unlocked{
                                c1 = c_red
                            }
                        }
                    }
                    draw_text_ext_color(1366-200, 200 + 25 * len + le, "Должен быть не изучен фокус " + "'" + fcs + "'",-1, 400, c1, c1, c1, c1, 1)
                    len+=1
                    le += string_height_ext("Должен быть не изучен фокус " + "'" + fcs + "'",-1, 400) - 25
                }
            }
        }
    }*/
    draw_text(1366-200, 225 + len * 25 + le, "Разблокирует следующее:")
     for (var i = 0; i < array_length(gives); i++){
        if gives[i][0] == "skill"{
            var re = object_get_safe_stats_shown(gives[i][1])
            draw_set_halign(fa_left)
            draw_text(1366-310, 225 + 25 * (i + len + 1) + le, re.variables.name)
            draw_sprite_ext(object_get_sprite(gives[i][1]), 1 , 1366-350, 225 + 25 * (i + len + 1) + le, 0.25, 0.25, 0, c_white, 1)
    }
        if gives[i][0] == "transformation"{
            var re = object_get_safe_stats_shown(gives[i][1])
            draw_set_halign(fa_left)
            draw_text_ext(1366-318, 225 + 25 * (i + len + 1) + le, "Персонаж превращается в: " + re.variables.name, -1, 250)
            draw_sprite_ext(object_get_sprite(gives[i][1]), 1 , 1366-360, 225 + 25 * (i + len + 1) + le, 0.25, 0.25, 0, c_white, 1)
            le += string_height_ext("Персонаж превращается в: " + re.variables.name, -1, 250) - 20
    }
    }
    if can_unlock() and !focus_unlocked{
        draw_set_halign(fa_center)    
        draw_text_color(1366-200, 600, "Доступно", c_green, c_lime, c_green, c_lime, 1)
        draw_set_halign(fa_left)    
        draw_text_color(1366-100, 700, "-" + string(focus_cost), c_red, c_red, c_red, c_red, 1)
    }
    else if focus_unlocked{
        draw_set_halign(fa_center)  
        draw_text_color(1366-200, 600, "Разблокировано", c_green, c_green, c_green, c_lime, 1)
    }
}