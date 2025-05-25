draw_set_font(fnt_result)
draw_set_halign(fa_center)
draw_rectangle_color(0, 0, 1366, 768, c_blue, c_red, c_red, c_blue, 0)
if global.winner != "draw" {draw_text(room_width/2, 25, "Победа " + string(global.winner) + " игрока!")} 
    else{
        draw_text(room_width/2, 25, "Ничья?")
    }
draw_text(room_width/2, 65, "Топ по нанесенному урону")
draw_sprite(tops[0].damage[0].sprite_index, 1, (room_width/3) - 64, 100)
draw_sprite_ext(tops[1].damage[0].sprite_index, 1, (room_width/3)*2 + 64, 100, -1, 1, 0, c_white, 1)
draw_text(room_width/3, 250, string(tops[0].damage[0].reff.variables.statistics.damage.last))
draw_text(room_width/3*2, 250, string(tops[1].damage[0].reff.variables.statistics.damage.last))
//draw_sprite(mvp[0].sprite_index, 1,  room_width/2 - 64, 150)
//draw_text(room_width/2, 300, string(mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(mvp[0].reff.variables.statistics.kda_last.assists)) 
draw_text(room_width/2, 300, "Топ по полученному урону")
draw_sprite(tops[0].damage_taken[0].sprite_index, 1, (room_width/3) - 64, 335)
draw_sprite_ext(tops[1].damage_taken[0].sprite_index, 1, (room_width/3)*2 + 64, 335, -1, 1, 0, c_white, 1)
draw_text(room_width/3, 475, string(tops[0].damage_taken[0].reff.variables.statistics.damage_taken.last))
draw_text(room_width/3*2, 475, string(tops[1].damage_taken[0].reff.variables.statistics.damage_taken.last))
if global.winner == "draw"{
    draw_text(room_width/2, 515, "MVP")
    draw_sprite(mvp[0].sprite_index, 1,  room_width/2 - 64, 550)
    draw_text(room_width/2, 700, string(mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(mvp[0].reff.variables.statistics.kda_last.assists))
}
else{
    if global.winner == 1{draw_text(room_width/3, 515, "MVP")}else{draw_text(room_width/3, 515, "SVP")}
    draw_sprite(tops[0].mvp[0].sprite_index, 1,  room_width/3 - 64, 550)
    draw_text(room_width/3, 700, string(tops[0].mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(tops[0].mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(tops[0].mvp[0].reff.variables.statistics.kda_last.assists))
    if global.winner == 1{draw_text(room_width/3 * 2, 515, "SVP")}else{draw_text(room_width/3 * 2, 515, "MVP")}
    draw_sprite_ext(tops[1].mvp[0].sprite_index, 1,  room_width/3*2 + 64, 550, -1, 1, 0, c_white, 1)
    draw_text(room_width/3*2, 700, string(tops[1].mvp[0].reff.variables.statistics.kda_last.kills) + ":" + string(tops[1].mvp[0].reff.variables.statistics.kda_last.deaths) + ":" + string(tops[1].mvp[0].reff.variables.statistics.kda_last.assists))
}
  