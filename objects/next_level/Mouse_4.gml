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