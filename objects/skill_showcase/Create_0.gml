sprite_index = object_get_sprite(origin.object_index)
mask_index = object_get_sprite(origin.object_index)
image_xscale = 0.5
image_yscale = 0.5
function object_get_safe_stats_shown(obj) {
    if typeof(obj) == "struct"{
        sprite_index = object_get_sprite(obj.object_index)
        mask_index = object_get_mask(obj.object_index)
        return obj
    }
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
reff = object_get_safe_stats_shown(origin)
alarm[0] = 1
function calculate(arr){
    var l = array_length(arr)
    if l == 0{
        return false
    }
    var str = ""
    for (var i = 0; i < l; i++){
        if string_starts_with(arr[i], "/"){
            str += string(reff.variables[$ string_replace(arr[i], "/", "")])
        }
        else{
            str += arr[i]
        }
    }
    return str
}