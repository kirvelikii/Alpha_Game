if page != ctrl_page{
    ctrl_page = page
    with skill_showcase{instance_destroy()}
    if page == "skills"{
        var first = noone
        for (var j = 0; j < array_length(data.variables.skills); j++){
            if j == 0{
                first = instance_create_layer(400 + 96 * j, 150, "UI", skill_showcase, {origin: data.variables.skills[j]})
            }
            else{
                instance_create_layer(400 + 96 * j, 150, "UI", skill_showcase, {origin: data.variables.skills[j]})
            }
            
        }
        with first {other.skill_chosen = self}
    }
    if page == "equipment"{
        
    }
}