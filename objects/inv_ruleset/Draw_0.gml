draw_set_color(c_white)
draw_line(100, 128, 100, 768)
draw_line(356, 128, 356, 768)
draw_line(356 + 256, 128, 356 + 256, 768)
draw_line_width(356 + 256 * 2, 0, 356 + 256 * 2, 768, 10)
draw_line_width(1360, 0, 1360, 768, 10)
draw_line(0, 128, 356 + 256 * 2, 128)
draw_set_halign(fa_center)
draw_set_font(fnt_focus)
draw_text((356 + 256 * 2) / 2, 10, "Подготовка к следующему бою")
var c = c_red
for (var i = 0; i < array_length(global.map); i++){
    var prev_c = c
    if global.map[i][0] == "red"{
        c = c_red
    }
    else if global.map[i][0] == "nobody"{
        c = c_gray
    }
    else if global.map[i][0] == "blue"{
        c = c_blue
    }
    if i != 0{
        draw_line_width_color(510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60 - 60, 100, 510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60, 100, 8, prev_c, c)
    }
}
var c = c_red
for (var i = 0; i < array_length(global.map); i++){
    var prev_c = c
    if global.map[i][0] == "red"{
        c = c_red
    }
    else if global.map[i][0] == "nobody"{
        c = c_gray
    }
    else if global.map[i][0] == "blue"{
        c = c_blue
    }
    draw_circle_color(510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60, 100, 16, c, c, 0)
    if global.mappos == i - 5{
        if team == 1{
            var sp = Sprite83
            var sid =  -1
        }
        else{var sp = Sprite83_1 var sid = 1}
        draw_sprite_ext(sp, 1, 510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60, 100, sid, 1, 0, c_white, 1)
        if team == 1{
            draw_set_halign(fa_left)
            draw_text_color(10, 10, "Союзные войска", c_red, c_red, c_red, c_red, 1)
            draw_set_halign(fa_right)
            draw_text_color(356 + 256 * 2 - 10, 10, "Вражеские войска и нейтралы", c_blue, c_blue, c_blue, c_blue, 1)
        }
        else{
            draw_set_halign(fa_left)
            draw_text_color(10, 10, "Вражеские войска и нейтралы", c_red, c_red, c_red, c_red, 1)
            draw_set_halign(fa_right)
            draw_text_color(356 + 256 * 2 - 10, 10, "Союзные войска", c_blue, c_blue, c_blue, c_blue, 1)
        }

    }
    if mouse_check_button_pressed(mb_left) and point_distance(mouse_x, mouse_y, 510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60, 100) <= 16{
        //draw_rectangle(510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60, 100, 510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60+100, 100+50, 0)
        chosen_map = i
        event_user(2)
    }
    if chosen_map = i{
        draw_circle_color(510 - 60 - 60 * ((array_length(global.map) - 1) / 2) + i * 60, 100, 16, c_yellow, c_yellow, 1)
    }
}