draw_self()
if char_page_ruleset.skill_chosen = self{
    draw_rectangle_color(x - 2, y - 2, x+66, y+66, c_yellow, c_yellow, c_white, c_yellow, 0)
    draw_self()
    draw_set_halign(fa_left)
    draw_text(400, 250, reff.variables.name)
    draw_text_ext(400, 275, reff.variables.description, -1, 800)
    draw_text(400, 350, "Сила: " + string(reff.variables.skill_power))
    draw_text(600, 350, "Цели: " + string(1 + reff.variables.sub_target_count) + ", " + string(reff.variables.target_type))
    draw_text(400, 375, "Перезарядка: " + string(reff.variables.cooldown / 60))
    draw_text(600, 375, "Криты(шанс, урон): " + string(reff.variables.crit_chance) + "%, " + string(reff.variables.crit_damage) + "X")
    draw_text(400, 400, "Эффекты: ")
}