name = "Шаблоннаая фракция"
side = "red"
color = c_purple
sprite = Sprite87
type = "faction"
spawn_point = [5]
has_base = false
has_army = true
army_spawn_pos = [3]
army_invasion_time = 400
armyy_start = [warrior, archer]
armyy = []
alarm[0] = 1
persistent = true
 for (var j = 0; j < array_length(armyy_start); j++){
                var ins = {reff: object_get_safe_stats_shown(armyy_start[j]), affinity: sprite, col: color}
                array_push(armyy, ins)
}
function invade(){
    var spawn = irandom(array_length(army_spawn_pos)-1)
    var spawn = army_spawn_pos[spawn]
    if side == "red"{
            for (var j = 0; j < array_length(armyy); j++){
                var ins = {reff: ruleset.object_get_safe_stats_shown(armyy[j], 1), affinity: sprite, col: color}
                var a = ruleset.create_from_template(ins, room_width / 2 - 256 - 128 - 256 * (2-spawn), 100 + j * 138, "Instances", 1, 0)
                array_push(ruleset.battlefield[spawn], a)
            }
        }
        else if side == "blue"{
            for (var j = 0; j < array_length(armyy); j++){
                var ins = {reff: ruleset.object_get_safe_stats_shown(armyy[j], 2), affinity: sprite, col: color}
                var b = ruleset.create_from_template(ins, room_width / 2 + 256 + 128 + 256 * (2-spawn), 100 + j * 138, "Instances", 2 , 6)
                array_push(ruleset.battlefield[spawn], b)}
        }
        else if side == "neutral"{
            for (var j = 0; j < array_length(armyy); j++){
                var ins = {reff: ruleset.object_get_safe_stats_shown(armyy[j], 0), affinity: sprite, col: color}
                var c = ruleset.create_from_template(ins, room_width / 2 - 256 - 128 - 256 * (2-spawn), 100 + j * 138, "Instances", 0, spawn)
                array_push(ruleset.battlefield[spawn], c)}
        }
    invaded = true
    ruleset.check_spaces()
}


function object_get_safe_stats_shown(obj, team=0) {
    if typeof(obj) == "struct"{
        return obj.reff
    }
    // Проверяем тип входных данных
    if (instance_exists(obj)) {
        // Работаем с экземпляром
        return get_instance_stats_shown(obj);
    }
    else if (object_exists(obj)) {
        // Работаем с шаблоном объекта
        return get_object_template_stats_shown(obj, team);
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

function get_object_template_stats_shown(obj_index, team=0) {
    // Создаем временный экземпляр для получения данных по умолчанию
    var temp_inst = instance_create_depth(0, 0, -10000, obj_index, {temp:true, team: team});
    var stats_shown = get_instance_stats_shown(temp_inst);
    instance_destroy(temp_inst);
    
    return stats_shown;
}