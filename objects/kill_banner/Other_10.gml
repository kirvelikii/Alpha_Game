//show_message([killer, death])
sp_kill = object_get_sprite(killer.type)
sp_assists = []
for (var i = 0; i < array_length(assists); i++){
    if instance_exists(assists[i]){
        array_push(sp_assists, object_get_sprite(assists[i].type))
    }
}
sp_death = death
if !kill{
    kill = true
    timer = 0
}
