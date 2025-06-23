draw_set_font(fnt_result)
draw_set_halign(fa_center)
if global.winner == 1 {var w = c_red} else {var w = c_blue}
if abs(global.mappos) > 5{
    var c = make_color_rgb(255, 215, 0)
    draw_rectangle_color(0, 0, 1366, 768, c, c_black, w, c_black, 0)
}
else{
    draw_rectangle_color(0, 0, 1366, 768, w, c_black, w, c_black, 0)
}
if abs(global.mappos) > 5{
    draw_text(room_width/2, 25, "Абсолютная Победа " + string(global.winner) + " игрока! Враг окончательно повержен! Великий день для всех нас")
}
else if global.winner != "draw" {draw_text(room_width/2, 25, "Победа " + string(global.winner) + " игрока!")} 
    else{
        draw_text(room_width/2, 25, "Ничья?")
    }
draw_text(room_width/2, 65, "Топ по нанесенному урону")
draw_sprite(tops[0].damage[0].sprite_index, 1, (room_width/3) - 64, 100)
draw_text((room_width/3), 225, tops[0].damage[0].reff.variables.nickname)
draw_sprite_ext(tops[1].damage[0].sprite_index, 1, (room_width/3)*2 + 64, 100, -1, 1, 0, c_white, 1)
draw_text((room_width/3)*2, 225, tops[1].damage[0].reff.variables.nickname)
draw_text(room_width/3, 255, string(tops[0].damage[0].reff.variables.statistics.damage.last))
draw_text(room_width/3*2, 255, string(tops[1].damage[0].reff.variables.statistics.damage.last))
//draw_sprite(mvp[0].sprite_index, 1,  room_width/2 - 64, 150)
//draw_text(room_width/2, 300, string(mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(mvp[0].reff.variables.statistics.kda_last.assists)) 
draw_text(room_width/2, 290, "Топ по полученному урону")
draw_sprite(tops[0].damage_taken[0].sprite_index, 1, (room_width/3) - 64, 325)
draw_sprite_ext(tops[1].damage_taken[0].sprite_index, 1, (room_width/3)*2 + 64, 325, -1, 1, 0, c_white, 1)
draw_text((room_width/3), 450, tops[0].damage_taken[0].reff.variables.nickname)
draw_text((room_width/3)*2, 450, tops[1].damage_taken[0].reff.variables.nickname)
draw_text(room_width/3, 480, string(tops[0].damage_taken[0].reff.variables.statistics.damage_taken.last))
draw_text(room_width/3*2, 480, string(tops[1].damage_taken[0].reff.variables.statistics.damage_taken.last))
if global.winner == "draw"{
    draw_text(room_width/2, 510, "MVP")
    draw_text((room_width/3), 530, mvp[0].reff.variables.nickname)
    draw_sprite(mvp[0].sprite_index, 1,  room_width/2 - 64, 560)
    draw_text(room_width/2, 700, string(mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(mvp[0].reff.variables.statistics.kda_last.assists))
}
else{
    if global.winner == 1{draw_text(room_width/3, 510, "MVP")}else{draw_text(room_width/3, 510, "SVP")}
    draw_sprite(tops[0].mvp[0].sprite_index, 1,  room_width/3 - 64, 560)
    draw_text((room_width/3), 530, tops[0].mvp[0].reff.variables.nickname)
    draw_text(room_width/3, 700, string(tops[0].mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(tops[0].mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(tops[0].mvp[0].reff.variables.statistics.kda_last.assists))
    if global.winner == 1{draw_text(room_width/3 * 2, 510, "SVP")}else{draw_text(room_width/3 * 2, 510, "MVP")}
    draw_sprite_ext(tops[1].mvp[0].sprite_index, 1,  room_width/3*2 + 64, 560, -1, 1, 0, c_white, 1)
    draw_text((room_width/3)*2, 530, tops[1].mvp[0].reff.variables.nickname)
    draw_text(room_width/3*2, 700, string(tops[1].mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(tops[1].mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(tops[1].mvp[0].reff.variables.statistics.kda_last.assists))
}
  