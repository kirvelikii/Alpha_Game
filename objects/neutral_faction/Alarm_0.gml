spawn = irandom(array_length(spawn_point)-1)
if has_base {base_pos = spawn}
army_pos = spawn_point[spawn]    
array_push(global.map[army_pos][1], {side: side, name: name, color: color, sprite: sprite, type: type})
if room = pre_fight{with inv_ruleset{event_user(2)}}
