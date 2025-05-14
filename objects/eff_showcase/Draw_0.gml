draw_self()
draw_set_halign(fa_right)
draw_set_valign(fa_middle)
if stats[1] == "main_target_enemy"{
    draw_text_transformed(x + 32, y + 32, "Main", 0.6, 0.6, 0)
}
else if stats[1] == "sub_target_enemy"{
    draw_text_transformed(x + 32, y + 32, "Sub", 0.6, 0.6, 0)
}
draw_set_valign(fa_top)