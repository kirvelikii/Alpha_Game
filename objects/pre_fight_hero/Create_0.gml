is_dragging = false;
drag_offset_x = 0;
drag_offset_y = 0;
con = 0
if inv_ruleset.team == 2{
    image_xscale = -1
}
function object_get_safe_data(obj) {
    if typeof(obj) == "struct"{
        sprite_index = object_get_sprite(obj.reff.object_index)
        mask_index = object_get_mask(obj.reff.object_index)
        return obj.reff
    }
    sprite_index = object_get_sprite(type)
    mask_index = object_get_mask(type)
    // Проверяем тип входных данных
    if (instance_exists(obj)) {
        // Работаем с экземпляром
        return get_instance_data(obj);
    }
    else if (object_exists(obj)) {
        // Работаем с шаблоном объекта
        return get_object_template_data(obj);
    }
    else {
        show_debug_message("Invalid object reference:", obj);
        return undefined;
    }
}

function get_instance_data(inst) {
    var data = {
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
                data.variables[$ var_name] = inst[$ var_name];
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
                data.variables[$ var_name] = inst[$ var_name];
            } catch(e) {
                show_debug_message("Failed to copy variable", var_name, ":", e);
            }
        }
    }
    return data;
}

function get_object_template_data(obj_index) {
    // Создаем временный экземпляр для получения данных по умолчанию
    var temp_inst = instance_create_depth(0, 0, -10000, obj_index, {temp:true});
    var data = get_instance_data(temp_inst);
    instance_destroy(temp_inst);
    
    return data;
}
reff = object_get_safe_data(type)
reff.variables.basic_attack += irandom(2)
if reff.variables.max_hp == 100{
    reff.variables.max_hp = irandom_range(90, 110)
    reff.variables.hp = reff.variables.max_hp
}
else{
    reff.variables.max_hp += irandom_range(1, 10)
    reff.variables.hp = reff.variables.max_hp
}
