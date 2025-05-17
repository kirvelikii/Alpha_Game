battlefield = [[], [], [], [], [], [], []]
global.blink_time = 0
randomize()
display_reset(0, true);
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
function check_win(){
    var teams = []
    with (hero){
        if !array_contains(teams, team) and hp > 0{
            array_push(teams ,team)
        }
    }
    if array_length(teams) == 1{
        show_debug_message(string(teams[0]) + " win")
        room = loot
        global.inv_team = 0
    }
    else if array_length(teams) == 0{
        show_debug_message(string("Draw"))
        room = loot
        global.inv_team = 0
} return 
}
function create_from_template(template, x, y, layer, team, pos) {
// Создаем экземпляр с начальными параметрами
    var inst = instance_create_layer(x, y, layer, template.reff.object_index, { team: team, temp: true, pos: pos});
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
        var yy = room_height / 2 - 64
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
        if arr[t].team == 1{
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
check_spaces()
check_win()