data = global.char_to_show.reff
avatarr = global.char_to_show.sprite_index
camera_pos_x = 688
camera_pos_y = 334
page = "info"
ctrl_page = "info"
skill_chosen = noone
stat_prew = false
function draw_stat_with_change(_x, _y, icon, value, stat_name) {
                draw_sprite(icon, 1, _x, _y)
                var text = string(value)
                var text_color = c_white
                //show_message(value * collision_point(mouse_x, mouse_y, obj_focus_block, false, false).stats_shown[$ (stat_name + "_perc")] )
                var stat_change = (real(collision_point(mouse_x, mouse_y, obj_focus_block, false, false).stats_shown[$ stat_name])) * (1 + real(collision_point(mouse_x, mouse_y, obj_focus_block, false, false).stats_shown[$ (stat_name + "_perc")]) + data.variables.modifer[$ stat_name]) + value * real(collision_point(mouse_x, mouse_y, obj_focus_block, false, false).stats_shown[$ (stat_name + "_perc")]) 
                if !is_undefined(stat_change) && stat_change != 0 {
                    var change_val = real(stat_change)
                    var change_str = (change_val >= 0 ? "+" : "") + string(stat_change)
                    text += " " + change_str
                    text_color = (change_val >= 0) ? c_green : c_red
                }
                draw_set_halign(fa_left)
                draw_text_color(_x + 32, _y, text, c_white, c_white, text_color, text_color, 1)
            }