function object_get_safe_stats_shown(obj) {
    if typeof(obj) == "struct"{
        sprite_index = object_get_sprite(obj.reff.object_index)
        mask_index = object_get_mask(obj.reff.object_index)
        return obj.reff
    }
    //sprite_index = object_get_sprite(type)
    //mask_index = object_get_mask(type)
    // Проверяем тип входных данных
    if (instance_exists(obj)) {
        // Работаем с экземпляром
        return get_instance_stats_shown(obj);
    }
    else if (object_exists(obj)) {
        // Работаем с шаблоном объекта
        return get_object_template_stats_shown(obj);
    }
    else {
        show_debug_message("Invalid object reference:", obj);
        return undefined;
    }
}

function get_instance_stats_shown(inst) {
    var stats_shown = {
        object_index: inst.object_index,
        variables: {}
    };
    
    // Получаем только изменяемые переменные
    var vars = variable_instance_get_names(inst);
    for (var i = 0; i < array_length(vars); i++) {
        var var_name = vars[i];
        
        // Пропускаем системные и служебные переменные
        if (!string_starts_with(var_name, "__") && var_name != "object_index") {
            try {
                stats_shown.variables[$ var_name] = inst[$ var_name];
            } catch(e) {
                show_debug_message("Failed to copy variable", var_name, ":", e);
            }
        }
    }
    var meths = (inst);
    for (var i = 0; i < array_length(meths); i++) {
        var var_name = meths[i];
        
        // Пропускаем системные и служебные переменные
        if (!string_starts_with(var_name, "__") && var_name != "object_index") {
            try {
                stats_shown.variables[$ var_name] = inst[$ var_name];
            } catch(e) {
                show_debug_message("Failed to copy variable", var_name, ":", e);
            }
        }
    }
    return stats_shown;
}

function get_object_template_stats_shown(obj_index) {
    // Создаем временный экземпляр для получения данных по умолчанию
    var temp_inst = instance_create_depth(0, 0, -10000, obj_index, {temp:true});
    var stats_shown = get_instance_stats_shown(temp_inst);
    instance_destroy(temp_inst);
    
    return stats_shown;
}
var aa = ds_map_values_to_array(focus_object_map);
global.char_to_show.reff.variables.focus_tree = []
for (var i = 0; i < array_length(aa); i++){
    var a = (object_get_safe_stats_shown(aa[i]).variables)
    //show_message(a)
    var strr = {
        focus_id: a.focus_id,
        focus_name: a.focus_name,
        focus_description: a.focus_description,
        focus_cost: a.focus_cost,
        focus_prerequisites: a.focus_prerequisites,
        focus_unlocked: a.focus_unlocked,
        focus_icon: a.focus_icon,
        focus_restrictions: a.focus_restrictions,
        stat_changes: a.stat_changes,
        gives: a.gives}
    //show_message(a.focus_unlocked)    
    array_push(global.char_to_show.reff.variables.focus_tree ,strr)
    }
//show_message(global.char_to_show.reff.variables.focus_tree)