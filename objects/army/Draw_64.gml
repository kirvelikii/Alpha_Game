if side == "red" or (side == "neutral" and inv_ruleset.team == 2){
    draw_set_halign(fa_left)}
else{
    draw_set_halign(fa_right)
}
if position_meeting(mouse_x, mouse_y, self){
    draw_text(min(max(10, x + 16), 356 + 256 * 2 - 42), y + 32, name)
}