if is_dragging{
    if instance_place(x + 32, y + 32, pre_fight_hero){
    var targ = instance_place(x + 32, y + 32, pre_fight_hero)
    if data.type = "stat_up"{
        for (var i = 0; i < array_length(data.effect); i++){
            //show_message(targ.reff)
            if string_ends_with(data.effect[i][0], "_perc"){
                targ.reff.variables[$ string_replace(data.effect[i][0], "_perc", "")] /= (1 + targ.reff.variables.modifer[$ string_replace(data.effect[i][0], "_perc", "")])
                targ.reff.variables[$ string_replace(data.effect[i][0], "_perc", "")] *= (1 + targ.reff.variables.modifer[$ string_replace(data.effect[i][0], "_perc", "")] + data.effect[i][1])
                targ.reff.variables.modifer[$ string_replace(data.effect[i][0], "_perc", "")] += data.effect[i][1]
            }
            else{
                //show_message(targ.reff.variables.modifer[$ data.effect[i][0]])
                targ.reff.variables[$ (data.effect[i][0])] += data.effect[i][1] * (1 + targ.reff.variables.modifer[$ data.effect[i][0]])}
            }

    }
    else{
        for (var i = 0; i < array_length(data.effect); i++){
            //show_message(targ.reff)
            if string_ends_with(data.effect[i][0], "_perc"){
                targ.reff.variables[$ string_replace(data.effect[i][0], "_perc", "")] /= (1 + targ.reff.variables.modifer[$ string_replace(data.effect[i][0], "_perc", "")])
                targ.reff.variables[$ string_replace(data.effect[i][0], "_perc", "")] *= (1 + targ.reff.variables.modifer[$ string_replace(data.effect[i][0], "_perc", "")] + data.effect[i][1])
                targ.reff.variables.modifer[$ string_replace(data.effect[i][0], "_perc", "")] += data.effect[i][1]
            }
            else{
                //show_message(targ.reff.variables.modifer[$ data.effect[i][0]])
                targ.reff.variables[$ (data.effect[i][0])] += data.effect[i][1] * (1 + targ.reff.variables.modifer[$ data.effect[i][0]])}
            }
        for (var j = 0; j < array_length(data.gives); j++){
                    if data.gives[j][0] == "skill"{
                        array_push(targ.reff.variables.skills, object_get_safe_stats_shown(data.gives[j][1]))
                }
            else if data.gives[j][0] == "buff"{
                        array_push(targ.reff.variables.starter_statuses, data.gives[j][1])
                }
                }
        var ree = object_get_safe_stats_shown(targ).variables
        data.owner = ree
        //show_message(data)
        array_push(targ.reff.variables.equips, data) 
        array_push(global.equipped_items[inv_ruleset.team - 1], data)
        //show_message(global.equipped_items)
        }    
    instance_destroy()
}
else{
    array_push(global.items, self)
    inv_ruleset.check_spaces_inv()
}
is_dragging = false;
inv_ruleset.drag_obj = noone
inv_ruleset.check_spaces_inv()    
}
