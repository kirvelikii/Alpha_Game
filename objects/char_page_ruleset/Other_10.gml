if page != ctrl_page{
    ctrl_page = page
    with skill_showcase{instance_destroy()} 
    with starter_tree{instance_destroy()}  
    with obj_focus_block{instance_destroy()}  
    with camera_man{char_page_ruleset.camera_pos_x = x; char_page_ruleset.camera_pos_y = y; x = 678; y = 334; alarm[0] = 1}      
    with equip_rule{instance_destroy()}
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
        instance_create_layer(0,0, "UI", equip_rule)
    }
    if page == "focus_tree"{
        instance_create_layer(camera_pos_x, camera_pos_y, "UI", camera_man)
        instance_create_layer(0, 0, "UI", starter_tree, {host: global.char_to_show})
        //instance_create_layer(0, 0, "Instances", obj_skill_tree_controller)
    }
}