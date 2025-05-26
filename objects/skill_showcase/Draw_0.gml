draw_self()
if char_page_ruleset.skill_chosen = self{
    draw_rectangle_color(x - 2, y - 2, x+66, y+66, c_yellow, c_yellow, c_white, c_yellow, 1)
    draw_self()
    draw_set_color(c_white)
    draw_set_halign(fa_left)
    draw_text(400, 250, reff.variables.name)
    draw_text_ext(400, 275, reff.variables.description, -1, 800)
    var yy = calculate(reff.variables.skill_power_shown_formula)
    if is_string(yy){
        draw_text(400, 350, "Сила: " + string(yy))
    }
    else{
        draw_text(400, 350, "Сила: " + string(reff.variables.skill_power_shown))
    }
    draw_text(700, 350, "Цели: " + string(1 + reff.variables.sub_target_count) + ", " + string(reff.variables.target_type))
    draw_text(400, 375, "Перезарядка: " + string(reff.variables.cooldown / 60))
    draw_text(700, 375, "Криты(шанс, урон): " + string(reff.variables.crit_chance) + "%, " + string(reff.variables.crit_damage) + "X")
    draw_text(700, 400, "Всего урона: " + string(reff.variables.statistics.damage.total))
    draw_text(400, 400, "Эффекты: ")
}