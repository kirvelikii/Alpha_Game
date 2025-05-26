//reff.variables.basic_attack += irandom(10)
if !mouse_check_button(mb_left){
    with inv_ruleset{
    //show_message(team)
    drag_obj = noone
    global.inv_team = team
    event_user(0)
}
global.char_to_show = self
room = char_list
}
