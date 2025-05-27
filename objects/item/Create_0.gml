sprite_index = data.texture
image_xscale = 0.5
image_yscale = 0.5
uid = id
is_dragging = false;
drag_offset_x = 0;
drag_offset_y = 0;
type = item
stats_shown = {
    max_hp: 0,
    basic_attack: 0,
    basic_range: 0,
    attack_interval: 0,
    basic_accuracy: 0,
    basic_crit_chance: 0,
    basic_crit_damage: 0,
    dodge_chance: 0,
    mov_speed: 0,
    max_sanity: 0,
    max_hp_perc: 0,
    basic_attack_perc: 0,
    basic_range_perc: 0,
    attack_interval_perc: 0,
    basic_accuracy_perc: 0,
    basic_crit_chance_perc: 0,
    basic_crit_damage_perc: 0,
    dodge_chance_perc: 0,
    mov_speed_perc: 0,
    max_sanity_perc: 0
}
for (var i = 0; i < array_length(data.effect); i++){
    //show_message(targ.reff)
    stats_shown[$ (data.effect[i][0])] = string(data.effect[i][1])}
//show_message(stats_shown)
function object_get_safe_stats_shown(obj) {
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