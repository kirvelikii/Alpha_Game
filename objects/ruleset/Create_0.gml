battlefield = [[], [], [], [], [], [], []]
randomize()
for (var i = 0; i < array_length(global.layout[0]); i++){
    for(var j = 0; j < array_length(global.layout[0][i]); j++){
        create_from_template(global.layout[0][i][j], room_width / 2 - 128 - 256 * (2-i), 100 + j * 138, "Instances", 1)}
}
for (var i = 0; i < array_length(global.layout[1]); i++){
    for(var j = 0; j < array_length(global.layout[1][i]); j++){
        create_from_template(global.layout[1][i][j], room_width / 2 + 128 + 256 * (2-i), 100 + j * 138, "Instances", 2)}
}
function check_win(){
    var teams = []
    with (hero){
        if !array_contains(teams, team) and hp > 0{
            array_push(teams ,team)
        }
    }
    if array_length(teams) == 1{
        show_message(string(teams[0]) + " win")
        room = loot
    }
    else if array_length(teams) == 0{
        show_message(string("Draw"))
        room = loot
} return 
}
function create_from_template(template, x, y, layer, team) {
// Создаем экземпляр с начальными параметрами
    var inst = instance_create_layer(x, y, layer, template.reff.object_index, { team: team, temp: true});
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
    with inst{
        temp = false
        instance_copy(true)
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
    return inst;
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