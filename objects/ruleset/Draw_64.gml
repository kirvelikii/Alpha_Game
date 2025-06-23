draw_set_font(-1)
draw_text(20, 10, fps)
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
        draw_line_width_color(710 - 30 - 30 * ((array_length(global.map) - 1) / 2) + i * 30 - 30, 40, 710 - 30 - 30 * ((array_length(global.map) - 1) / 2) + i * 30, 40, 4, prev_c, c)
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
    draw_circle_color(710 - 30 - 30 * ((array_length(global.map) - 1) / 2) + i * 30, 40, 8, c, c, 0)
    if global.mappos == i - 5{
        draw_sprite_ext(Sprite86, 1, 710 - 30 - 30 * ((array_length(global.map) - 1) / 2) + i * 30 - 16, 24, 0.5, 0.5, 0, c_white, 1)
    }
}