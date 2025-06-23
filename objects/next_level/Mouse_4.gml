if array_length(global.layout_t1[0]) or array_length(global.layout_t1[1]) or array_length(global.layout_t1[2]){
team = inv_ruleset.team
global.loot[team-1] = []
if inv_ruleset.team < 2{
    with inv_ruleset {event_user(0)}
}
else{
    with inv_ruleset {event_user(0)} 
    global.inv_team = 0        
    room = fight
}
}