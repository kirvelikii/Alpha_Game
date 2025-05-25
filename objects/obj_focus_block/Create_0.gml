
hover_scale = 1.1;      // Масштаб при наведении
current_scale = 1;      // Текущий масштаб (инициализируем!)
target_scale = 1;       // Целевой масштаб
is_mouse_over = false;  // Флаг наведения
mask_index = focus_mask
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
for (var i = 0; i < array_length(stat_changes); i++){
            //show_message(targ.reff)
            stats_shown[$ (stat_changes[i][0])] = stat_changes[i][1]}
function can_unlock() {
    if (global.char_to_show.reff.variables.expp < focus_cost) return false;
     //for (var i = 0; i<array_length(focus_restrictions); i++ ){
        //if i != 0{show_message(0)}        
        /*for (var j = 0; j < array_length(focus_restrictions[i]); j++){
            if !string_starts_with(focus_restrictions[i][j], "!"){
                if string_starts_with(focus_restrictions[i][j], "f"){
                    //show_message(focus_restrictions[i][j])
                    var cl = c_red
                    var need = string_copy(focus_restrictions[i][j], 2, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                cl = c_lime
                            }
                        }
                    }
                        if cl != c_lime{if (i < array_length(focus_restrictions) - 1) {break} else {return false}}
                }
                }
                else{
                if string_starts_with(focus_restrictions[i][j], "!f"){
                    //show_message(focus_restrictions[i][j])
                    var c1 = c_lime
                    var need = string_copy(focus_restrictions[i][j], 3, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                c1 = c_red
                            }
                        }
                    }
                    if c1 != c_lime{if (i < array_length(focus_restrictions) - 1) {break} else {return false}}
                        
                }
            }
        }
        return true;*/
    //}
    //show_message(0)
    return check_focus_requirements();
}
function apply_effects(){
    var targ = starter_tree.host
    var a = struct_get_names(stats_shown)
    for (var i = 0; i < array_length(a); i++){
        if string_ends_with(a[i], "_perc"){
                targ.reff.variables[$ string_replace(a[i], "_perc", "")] /= (1 + targ.reff.variables.modifer[$ string_replace(a[i], "_perc", "")])
                targ.reff.variables[$ string_replace(a[i], "_perc", "")] *= (1 + stats_shown[$ a[i]] + targ.reff.variables.modifer[$ string_replace(a[i], "_perc", "")])
                targ.reff.variables.modifer[$ string_replace(a[i], "_perc", "")] += stats_shown[$ a[i]]
            }
            else{
                //show_message(targ.reff.variables.modifer[$ a[i]])
                targ.reff.variables[$ (a[i])] += stats_shown[$ a[i]] * (1 + targ.reff.variables.modifer[$ a[i]])}
            }
    for (var i = 0; i < array_length(gives); i++){
        if gives[i][0] == "skill"{
            array_push(targ.reff.variables.skills, gives[i][1])
    }
        if gives[i][0] == "transformation"{
            var re = object_get_safe_stats_shown(gives[i][1])
            var pre = object_get_safe_stats_shown(global.char_to_show.reff.object_index)
            var nam = struct_get_names(re.variables)
            var new_obj = re
            add_stats = []
            for (var j = 0; j < array_length(nam); j++){
                if array_contains(struct_get_names(stats_shown), nam[j]){
                    new_obj.variables[$ nam[j]] += global.char_to_show.reff.variables[$ nam[j]] - pre.variables[$ nam[j]] 
                }
                else if nam[j] == "skills"{
                    /*var add_skills = []
                    for (var t = 0; t < array_length(pre.variables.skills); t++){
                        if !array_contains(pre.variables.legacy_skills, pre.variables.skills[t]){
                            array_push(add_skills, pre.variables.skills[t])
                        }
                        else{
                            
                        }
                    }*/
                    //show_message([new_obj.variables.skills, global.char_to_show.reff.variables.skills, global.char_to_show.reff.variables.legacy_skills])
                    new_obj.variables.skills = array_union(new_obj.variables.skills, array_subtract(global.char_to_show.reff.variables.skills, global.char_to_show.reff.variables.legacy_skills))
                    //show_message(new_obj.variables.skills)
                }
                else if nam[j] == "focus_tree"{
                    new_obj.variables.focus_tree = global.char_to_show.reff.variables.focus_tree}
                else if nam[j] == "statistics"{
                    new_obj.variables.statistics = global.char_to_show.reff.variables.statistics
                }
                else if nam[j] == "uid"{
                    new_obj.variables.uid = global.char_to_show.reff.variables.uid
                }
                else if nam[j] == "equips"{
                    new_obj.variables.equips = global.char_to_show.reff.variables.equips
                }
                else if nam[j] == "starter_buffs"{
                    new_obj.variables.starter_buffs = global.char_to_show.reff.variables.starter_buffs
                }
            }
            global.char_to_show.reff = new_obj
            global.char_to_show.sprite_index = object_get_sprite(gives[i][1])
            with char_page_ruleset {event_user(1)}
    }}
    }
function object_get_safe_stats_shown(obj) {
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
function array_subtract(arr1, arr2) {
    var result = []
    array_copy(result, 0, arr1, 0, array_length(arr1));
    var len2 = array_length(arr2);
    
    for (var i = 0; i < len2; i++) {
        var index = array_get_index(result, arr2[i]);
        array_delete(result, index, 1);
        }
    //show_message(result)
    return result;
}
function check_focus_requirements() {
    return evaluate_requirements(focus_restrictions);
}

function evaluate_requirements(conditions) {
    if (is_string(conditions)) {
        // Простое условие (фокус или отрицание)
        return check_single_condition(conditions);
    }
    
    if (is_array(conditions)) {
        // Старая система (все условия должны быть выполнены - AND)
        for (var i = 0; i < array_length(conditions); i++) {
            if (!check_single_condition(conditions[i])) return false;
        }
        return true;
    }
    
    // Новая система с логическими операторами (для структур)
    if (is_struct(conditions)) {
        // Проверяем наличие ключей в структуре
        if (variable_struct_exists(conditions, "or")) {
            var options = conditions[$ "or"];
            for (var i = 0; i < array_length(options); i++) {
                if (evaluate_requirements(options[i])) return true;
            }
            return false;
        }
        
        if (variable_struct_exists(conditions, "and")) {
            var requirements = conditions[$ "and"];
            for (var i = 0; i < array_length(requirements); i++) {
                if (!evaluate_requirements(requirements[i])) return false;
            }
            return true;
        }
        
        if (variable_struct_exists(conditions, "min")) {
            var min_count = conditions[$ "min"];
            var options = conditions[$ "from"];
            var count = 0;
            
            for (var i = 0; i < array_length(options); i++) {
                if (check_single_condition(options[i])) count++;
                if (count >= min_count) return true;
            }
            return false;
        }
        
        if (variable_struct_exists(conditions, "not")) {
            return !evaluate_requirements(conditions[$ "not"]);
        }
    }
    
    return false;
}
function check_single_condition(cond) {
    if (string_char_at(cond, 1) == "!") {
        if (string_char_at(cond, 2) == "f"){
        var focus_id = string_copy(cond, 3, string_length(cond)-1);
        return !is_focus_unlocked(focus_id);}
    }
    else{
        if (string_char_at(cond, 1) == "f"){
            var focus_id = string_copy(cond, 2, string_length(cond)-1);
            return is_focus_unlocked(focus_id);
    }
}}

function is_focus_unlocked(f){
    with (obj_focus_block){
        if focus_id == f{
            return focus_unlocked
        }
}}

function draw_focus_requirements(x, y, requirements) {
    // Очищаем кэш имен фокусов
    var __focus_name_cache = ds_map_create();
    
    var current_y = y;
    draw_text(x, current_y, "Требования:");
    current_y += 25;
    
    // Если требования не заданы
    if (is_undefined(requirements)) {
        draw_text(x, current_y, "Нет требований");
        ds_map_destroy(__focus_name_cache);
        return current_y + 25;
    }
    
    // Рекурсивная отрисовка
    current_y = draw_requirement_node(x, current_y, requirements, 0, __focus_name_cache);
    
    ds_map_destroy(__focus_name_cache);
    return current_y;
}

function draw_requirement_node(x, y, node, indent, name_cache) {
    le = y - 200
    var current_y = y;
    var indent_str = string_repeat("    ", indent);
    var line_height = 25;
    var max_width = 300;
    if node == [] {draw_text_color(x, current_y, "Нет", color, color, color, color, 1)
                    return current_y + line_height}

    else if (is_string(node)) {
        // Отрисовка простого условия (фокус или !фокус)
        var color, text, focus_id, unlocked;
        
        if (string_starts_with(node, "!")) {
            if (string_char_at(node, 2) == "f"){
            focus_id = string_copy(node, 3, string_length(node)-1);
            unlocked = is_focus_unlocked(focus_id);
            color = unlocked ? c_red : c_green;
            text = indent_str + "НЕ изучен: " + get_focus_name(focus_id);}
        } else if (string_char_at(node, 1) == "f"){
            focus_id = string_copy(node, 2, string_length(node)-1);
            unlocked = is_focus_unlocked(focus_id);
            color = unlocked ? c_green : c_red;
            text = indent_str + "Изучен: " + get_focus_name(focus_id);
        }
        
        draw_text_color(x, current_y, text, color, color, color, color, 1);
        return current_y + line_height;
    }
    else if (is_array(node)) {
        // Совместимость со старой системой (все условия И)
        //draw_text(x, current_y, indent_str + "Все условия должны быть выполнены:");
        //current_y += line_height;
        
        for (var i = 0; i < array_length(node); i++) {
            current_y = draw_requirement_node(x, current_y, node[i], indent + 1, name_cache);
        }
        return current_y;
    }
    else if (is_struct(node)) {
        // Обработка новых логических структур
        if (variable_struct_exists(node, "or")) {
            draw_text(x, current_y, indent_str + "Хотя бы одно из:");
            current_y += line_height;
            
            var options = node[$ "or"];
            for (var i = 0; i < array_length(options); i++) {
                current_y = draw_requirement_node(x, current_y, options[i], indent + 1, name_cache);
            }
            return current_y;
        }
        else if (variable_struct_exists(node, "and")) {
            //draw_text(x, current_y, indent_str + "Все условия:");
            //current_y += line_height;
            
            var conditions = node[$ "and"];
            for (var i = 0; i < array_length(conditions); i++) {
                current_y = draw_requirement_node(x, current_y, conditions[i], indent + 1, name_cache);
            }
            return current_y;
        }
        else if (variable_struct_exists(node, "min")) {
            var min_count = node[$ "min"];
            var options = node[$ "from"];
            
            // Подсчет выполненных условий
            var completed = 0;
            for (var i = 0; i < array_length(options); i++) {
                if (check_single_condition(options[i])) completed++;
            }
            
            var progress_text = " (" + string(completed) + "/" + string(min_count) + ")";
            var progress_color = (completed >= min_count) ? c_green : c_red;
            
            draw_text(x, current_y, indent_str + "Выполнено хотя бы " + string(min_count) + " из:");
            draw_text_color(x + string_width(indent_str + "Выполнено хотя бы " + string(min_count) + " из:"), 
                          current_y, progress_text, progress_color, progress_color, progress_color, progress_color, 1);
            current_y += line_height;
            
            for (var i = 0; i < array_length(options); i++) {
                current_y = draw_requirement_node(x, current_y, options[i], indent + 1, name_cache);
            }
            return current_y;
        }
        else if (variable_struct_exists(node, "not")) {
            draw_text(x, current_y, indent_str + "НЕ должно быть выполнено:");
            current_y += line_height;
            current_y = draw_requirement_node(x, current_y, node[$ "not"], indent + 1, name_cache);
            return current_y;
        }
        else {
            // Неизвестная структура
            draw_text_color(x, current_y, indent_str + "Неизвестный тип условия", c_red, c_red, c_red, c_red, 1);
            return current_y + line_height;
        }
    }
    else {
        // Неизвестный тип условия
        draw_text_color(x, current_y, indent_str + "Неизвестный тип условия", c_red, c_red, c_red, c_red, 1);
        return current_y + line_height;
    }
    
    return current_y;
}

function get_focus_name(f){
    with obj_focus_block{
        if focus_id == f{
            return focus_name
        }
    }
}