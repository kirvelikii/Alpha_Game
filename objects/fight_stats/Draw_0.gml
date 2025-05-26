draw_rectangle_color(0, 800, 2049, 1152, c_black, c_black, c_black, c_black, 0) 
draw_set_font(fnt_focus)
//draw_text(350, 800, "Убийств        Смертей          Помощи         Урон        Полученный      Полученный        Урон         Убийств        Смертей          Помощи")
if global.chosen_pers == noone{
    with hero{
        if statistics.damage.last > 0 or statistics.damage_taken.last > 0{
        var scor = other.calculate_mvp_score(self)
        ti = uid
        if team == 1{
            var in = array_find_index(other.tops1, function f(a){if a[0].uid == other.ti return true else return false})
            if in == -1{
                 array_push(other.tops1, [self, scor, uid])
            }
            else{
                other.tops1[in][1] = scor
            }
        }
        else {
            var in = array_find_index(other.tops2, function ff(a){if a[0].uid == other.ti return true else return false})
            if in == -1{
                 array_push(other.tops2, [self, scor, uid])
            }
            else{
                other.tops2[in][1] = scor
            }
        }    }
    }
    if tops1[0][1] != 0{array_sort(tops1, function (a, b) {if a[1] == b[1] return true else return a[1] < b[1]})}
    if tops2[0][1] != 0{array_sort(tops2, function (a, b) {if a[1] == b[1] return true else return a[1] < b[1]})}
    draw_set_halign(fa_center)
    draw_set_valign(fa_top)
    var posl = ["Убийств", "Смертей", "Помощи", "Нанесенный урон", "Полученный урон", "Полученный урон", "Нанесенный урон", "Помощи", "Смертей", "Убийств"]
    for (var ry = 0; ry < 10; ry++){
        draw_line(250 + 150 * ry, 800, 250 + 150 * ry, 1152)
        draw_text_ext(250 + 150 * ry + 75, 800, posl[ry], -1, 100)
    }
    draw_line(250 + 150 * 10, 800, 250 + 150 * 10, 1152)
    var poss = ["kills", "deaths", "assists", "damage", "damage_taken"]
    for (var i = 0; i < array_length(tops1); i++){
        draw_set_halign(fa_left)
        draw_set_valign(fa_top)
        if instance_exists(tops1[i][0]){
            draw_sprite_ext((tops1[i][0].sprite_index), 1, 50, 832 + 64 * i, 0.5, 0.5, 0, c_white, 1)
            tops1[i][0].draw_my_healthbar(50, 50-10, 832 + 64 * (i), 832 + 64 * (i + 1), 64)
        }
        else{
            draw_sprite_ext((tops1[i][0].sprite_index), 1, 50, 832 + 64 * i, 0.5, 0.5, 0, c_red, 1)
        }
        draw_text(150, 832 + 16 + 64 * i, string(i+1) + " " + tops1[i][0].name)
        draw_set_halign(fa_center)
        draw_set_valign(fa_middle)
        for (var t = 0; t < 5; t++){
            if t<=2{
                draw_text(250 + 150 * t + 75, 832 + 64 * i + 32, tops1[i][0].statistics.kda_last[$ poss[t]])
            }
            else{
                draw_text(250 + 150 * t + 75, 832 + 64 * i + 32, tops1[i][0].statistics[$ poss[t]].last)
            }

        }
    }
    for (var i = 0; i < array_length(tops2); i++){
        draw_set_halign(fa_right)
        draw_set_valign(fa_top)
        if instance_exists(tops2[i][0]){
            draw_sprite_ext((tops2[i][0].sprite_index), 1, 1999, 832 + 64 * i, -0.5, 0.5, 0, c_white, 1)
            tops2[i][0].draw_my_healthbar(1999, 1999+10, 832 + 64 * (i), 832 + 64 * (i + 1), 64)
        }
        else{
            draw_sprite_ext((tops2[i][0].sprite_index), 1, 1999, 832 + 64 * i, -0.5, 0.5, 0, c_red, 1)
        }
        draw_text(1899, 832 + 16 + 64 * i, tops2[i][0].name + " " + string(i+1))
        draw_set_halign(fa_center)
        draw_set_valign(fa_middle)
        for (var t = 0; t < 5; t++){
            if t<=2{
                draw_text(1799 - 150 * t - 125, 832 + 64 * i + 32, tops2[i][0].statistics.kda_last[$ poss[t]])
            }
            else{
                draw_text(1799 - 150 * t - 125, 832 + 64 * i + 32, tops2[i][0].statistics[$ poss[t]].last)
            }

        }
    }
}
    