
hover_scale = 1.1;      // Масштаб при наведении
current_scale = 1;      // Текущий масштаб (инициализируем!)
target_scale = 1;       // Целевой масштаб
is_mouse_over = false;  // Флаг наведения
mask_index = focus_mask
function can_unlock() {
    if (global.player_exp < focus_cost) return false;
     for (var i = 0; i<array_length(focus_restrictions); i++ ){
        //if i != 0{show_message(0)}        
        for (var j = 0; j < array_length(focus_restrictions[i]); j++){
            if !string_starts_with(focus_restrictions[i][j], "!"){
                if string_starts_with(focus_restrictions[i][j], "f"){
                    //show_message(focus_restrictions[i][j])
                    var cl = c_red
                    var need = string_copy(focus_restrictions[i][j], 2, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                cl = c_lime
                            }
                        }
                    }
                        if cl != c_lime{if (i < array_length(focus_restrictions) - 1) {break} else {return false}}
                }
                }
                else{
                if string_starts_with(focus_restrictions[i][j], "!f"){
                    //show_message(focus_restrictions[i][j])
                    var c1 = c_lime
                    var need = string_copy(focus_restrictions[i][j], 3, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                c1 = c_red
                            }
                        }
                    }
                    if c1 != c_lime{if (i < array_length(focus_restrictions) - 1) {break} else {return false}}
                        
                }
            }
        }
        return true;
    }
    //show_message(0)
    return true;
}