battlefield = [[], [], [], [], [], [], []]
global.blink_time = 0
randomize()
sdvg = 0
display_reset(0, true);
for (var i = 0; i<array_length(global.map[global.mappos+5][1]); i++){
    if global.map[global.mappos+5][1][i].type == "army"{
        if global.map[global.mappos+5][1][i].side == "red"{
            for (var j = 0; j < array_length(global.map[global.mappos+5][1][i].contains); j++){
                var ins = {reff: object_get_safe_stats_shown(global.map[global.mappos+5][1][i].contains[j], 1), affinity: global.map[global.mappos+5][1][i].sprite, col: global.map[global.mappos+5][1][i].color}
                var a = create_from_template(ins, room_width / 2 - 256 - 128 - 256 * (0), 100 + j * 138, "Instances", 1, 0)
                array_push(battlefield[0], a)
            }
        }
        else if global.map[global.mappos+5][1][i].side == "blue"{
            for (var j = 0; j < array_length(global.map[global.mappos+5][1][i].contains); j++){
                var ins = {reff: object_get_safe_stats_shown(global.map[global.mappos+5][1][i].contains[j], 2), affinity: global.map[global.mappos+5][1][i].sprite, col: global.map[global.mappos+5][1][i].color}
                var b = create_from_template(ins, room_width / 2 + 256 + 128 + 256 * (2), 100 + j * 138, "Instances", 2 , 6)
                array_push(battlefield[6], b)}
        }
    }
}
for (var i = 0; i < array_length(global.layout[0]); i++){
    for(var j = 0; j < array_length(global.layout[0][i]); j++){
        var a = create_from_template(global.layout[0][i][j], room_width / 2 - 256 - 128 - 256 * (2-i), 100 + j * 138, "Instances", 1, i)
        array_push(battlefield[i], a)
}}
for (var i = 0; i < array_length(global.layout[1]); i++){
    for(var j = 0; j < array_length(global.layout[1][i]); j++){
        var b = create_from_template(global.layout[1][i][j], room_width / 2 + 256 + 128 + 256 * (2-i), 100 + j * 138, "Instances", 2 , 6 - i)
        array_push(battlefield[6-i], b)
}}
function save_teams() {
    var save = global.layout;
    // Чтение существующих данных
    var save_data = {};
    if (file_exists("save.json")) {
        var file = file_text_open_read("save.json");
        if (file != -1) {  // Проверка успешного открытия файла
            var json_string = file_text_read_string(file);
            file_text_close(file);  // Важно закрыть файл после чтения!
            
            try {
                save_data = json_parse(json_string);
            } catch (e) {
                show_message("Ошибка парсинга JSON: " + string(e));
                save_data = {};
            }
        }
    }
    // Обновление данных
    var round_key = string(global.round);
    if (is_struct(save_data)){  // Проверка, что save_data - структура
        if (variable_struct_exists(save_data, round_key)) {
            if (is_array(save_data[$ round_key])) {
                save_data[$ round_key] = array_union(save_data[$ round_key], save);
            } else {
                save_data[$ round_key] = [save_data[$ round_key], save];
            }
        } else {
            save_data[$ round_key] = [save];
        }
    } else {
        save_data = ds_map_create();
        save_data[? round_key] = [save];
    }
    //show_debug_message(save_data)
    // Запись новых данных
    var filee = file_text_open_write("save.json");
    if (filee != -1) {  // Проверка успешного открытия файла
        var json_str = json_stringify(save_data);
        file_text_write_string(filee, json_str);
        file_text_close(filee);  // Важно закрыть файл после записи!
    } else {
        show_message("Не удалось открыть файл для записи");
    }
}
function check_win(){
    var teams = []
    with (hero){
        if !array_contains(teams, team) and hp > 0{
            array_push(teams ,team)
        }
    }
    if array_length(teams) == 1{
        //show_debug_message(string(teams[0]) + " win")
        global.winner = teams[0]
        global.inv_team = 0
        room = post_fight
    }
    else if array_length(teams) == 0{
        //show_debug_message(string("Draw"))
        global.winner = "draw"
        global.inv_team = 0
        room = post_fight
} return 
}
function create_from_template(template, x, y, layer, team=0, pos=0) {
// Создаем экземпляр с начальными параметрами
    if struct_exists(template, "affinity"){
        var aff = template.affinity
        var col = template.col
    }
    else{
        if team == 1{
            var aff = Sprite87
            var col = c_red
        }
        else if team == 2{
            var aff = Sprite87
            var col = c_blue
        }
        else{
            var aff = Sprite87
            var col = c_gray
        }
    }
    var inst = instance_create_layer(x, y, layer, template.reff.object_index, {team: team, temp: true, pos: pos, aff: aff, afc: col});
    //instance_deactivate_object(inst)
    if (!instance_exists(inst)) return noone;
    //instance_deactivate_object(inst)
    // Копируем обычные переменные
    if (variable_struct_exists(template.reff, "variables")) {
        var vars = template.reff.variables;
        var var_names = variable_struct_get_names(vars);
        for (var i = 0; i < array_length(var_names); i++) {
            var name = var_names[i];
            variable_instance_set(inst, name, struct_get(vars, name))
            //inst[$ name] = struct_get(vars, name)
                //show_message(vars[$ name])
        }
    }
    var instt = noone
    with inst{
        temp = false
        instt = instance_copy(true)
        instance_destroy()
    }
    //show_message(inst.hp)
    //inst.attack(self)
    //instance_activate_object(inst)
    // Копируем методы с привязкой контекста
    /*if (variable_struct_exists(template.reff, "methods")) {
        var methods = template.reff.methods;
        var method_names = variable_struct_get_names(methods);
        
        for (var i = 0; i < array_length(method_names); i++) {
            var m_name = method_names[i];
            inst[$ m_name] = method(inst, methods[$ m_name]);
        }
    }*/
    return instt;
}
function create_from_template_1(template, x, y, layer, team) {
    // 1. Создаем временный объект-контейнер
    var container = instance_create_layer(x, y, layer, obj_template_container, {
        template_data: template,
        target_layer: layer,
        target_team: team
    });
// Вернет созданный объект
}
function clean_battlefield(){
    for (var i = 0; i < array_length(battlefield); i++){
        for (var j = 0; j < array_length(battlefield[i]); j++){
            if battlefield[i][j] == noone {
                array_delete(battlefield[i], j, 1)
            }
        }
    }
}
function check_spaces(){
    clean_battlefield()
    for (var p = 0; p < array_length(battlefield); p++){
        var tt = column_get_teams(battlefield[p])
        var yy = room_height / 2 - 64 - sdvg
        var count = array_length(tt[0])
        var spacing = 128
        for (var i = 0; i < array_length(tt[0]); i++) { 
            var offset = spacing * (count - 1) * 0.5;
            tt[0][i].y = yy - offset + (i) * spacing;
    }
        var countt = array_length(tt[1])
        var spacingg = 128
        for (var j = 0; j < array_length(tt[1]); j++) { 
            var offset = spacingg * (countt - 1) * 0.5;
            tt[1][j].y = yy - offset + (j) * spacingg;
}}}
function column_get_teams(arr){
    t1 = []
    t2 = []
    for (var t = 0; t < array_length(arr); t++){
        if instance_exists(arr[t]){
        if arr[t].team == 1 or (arr[t].team != 2 and image_xscale = 1){
            array_push(t1, arr[t])
        }
        else{
            array_push(t2, arr[t])
        }
        }
        else{
            clean_battlefield()
        }
        
    }
    return [t1, t2]
}
/*reff.variables.basic_attack += irandom(2)
if reff.variables.max_hp == 100{
    reff.variables.max_hp = irandom_range(90, 110)
    reff.variables.hp = reff.variables.max_hp
}
else{
    reff.variables.max_hp += irandom_range(1, 10)
    reff.variables.hp = reff.variables.max_hp
}*/
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
check_spaces()
check_win()
