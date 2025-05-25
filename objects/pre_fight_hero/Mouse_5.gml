//reff.variables.basic_attack += irandom(10)
with inv_ruleset{
    //show_message(team)
    global.inv_team = team
    event_user(0)
}
global.char_to_show = self
room = char_list