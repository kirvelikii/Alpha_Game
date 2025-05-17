var _alpha = focus_unlocked ? 1 : 0.5;
// 2. Рисуем сам фокус
if (sprite_exists(focus_icon)) {
    draw_sprite_ext(focus_icon, 0, x, y, current_scale, current_scale, 0, c_white, _alpha);
}
// Подсветка связей при наведении
if (is_mouse_over) {
    draw_set_color(c_yellow);
    draw_set_alpha(0.9);
    
    // Подсвечиваем связи с родителями
    for (var i = 0; i < array_length(focus_prerequisites); i++) {
        var parent = starter_tree.get_focus_object(focus_prerequisites[i]);
        if (parent != noone) {
            var middle_y = parent.y + (y - parent.y) / 2 + 64;
            
            // Вертикальная часть
            draw_line_width(parent.x, parent.y, parent.x, middle_y, 4);
            
            // Горизонтальная часть
            draw_line_width(parent.x, middle_y, x, middle_y, 4);
            
            // Вертикальная часть к текущему узлу
            draw_line_width(x, middle_y, x, y, 4);
        }
    }
    
    draw_set_alpha(1);}


 for (var i = 0; i<array_length(focus_restrictions); i++ ){
        for (var j = 0; j < array_length(focus_restrictions[i]); j++){
            if string_starts_with(focus_restrictions[i][j], "!f"){
                    //show_message(focus_restrictions[i][j])
                    var cl = c_lime
                    var ins = noone
                    var need = string_copy(focus_restrictions[i][j], 2, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                cl = c_red
                            }
                            ins = self
                        }
                    }
                //show_message(ins)
                if ins != noone {draw_arrow(x + 32, y + 88, ins.x + 32, ins.y+88, 5)}
                }
        }
    }
if focus_unlocked {var col = c_white} else {var col = c_gray}

draw_sprite_ext(focus_table, 1, x - 32, y + 64, 1, 1, 0, col, 1)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_set_font(fnt_focus)
draw_text_ext_color(x+32, y + 64 + 24,  focus_name, -1, 128, c_white, c_white, c_white, c_ltgray, 1)