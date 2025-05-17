
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
    if (global.player_exp < focus_cost) return false;
     for (var i = 0; i<array_length(focus_restrictions); i++ ){
        //if i != 0{show_message(0)}        
        for (var j = 0; j < array_length(focus_restrictions[i]); j++){
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
        return true;
    }
    //show_message(0)
    return true;
}
function apply_effects(){
    var targ = starter_tree.host
    var a = struct_get_names(stats_shown)
    for (var i = 0; i < array_length(a); i++){
        if string_ends_with(a[i], "_perc"){
                targ.reff.variables[$ string_replace(a[i], "_perc", "")] *= (1 + stats_shown[$ a[i]])
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