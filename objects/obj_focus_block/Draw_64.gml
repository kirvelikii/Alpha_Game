if position_meeting(mouse_x, mouse_y, self){
    draw_sprite(vsp_s, 1, 0, 0)
    //draw_sprite_ext(Sprite18, 1, 0, 0, 0.5, 0.5, 0, c_white, 0.3)
    draw_sprite(focus_icon, 1, 20, 20)
    draw_set_halign(fa_center)
    draw_text(200, 50, focus_name)
    draw_text(200, 100, focus_description)
    draw_text(200, 175, "Цена: " + string(focus_cost))
    if !focus_unlocked and can_unlock(){ 
        draw_set_halign(fa_left)
        draw_text_color(10, 700, "-" + string(focus_cost), c_red, c_white, c_red, c_red, 1)
        draw_set_halign(fa_center)
    }
    draw_text(200, 200, "Требования:")
    var len = 1
    for (var i = 0; i<array_length(focus_restrictions); i++ ){
        if i != 0{draw_text(200, 200 + 25 * len, "Или"); len+=1}
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
                    draw_text_color(200, 200 + 25 * len, "Должен быть изучен фокус " + "'" + fcs + "'", cl, cl, cl, cl, 1)
                    len+=1
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
                    draw_text_color(200, 200 + 25 * len, "Должен быть не изучен фокус " + "'" + fcs + "'", c1, c1, c1, c1, 1)
                    len+=1
                }
            }
        }
    }
    if can_unlock() and !focus_unlocked{
        draw_text_color(200, 600, "Доступно", c_green, c_lime, c_green, c_lime, 1)
    }
    else if focus_unlocked{
        draw_text_color(200, 600, "Разблокировано", c_green, c_green, c_green, c_lime, 1)
    }
}