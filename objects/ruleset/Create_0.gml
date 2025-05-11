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
function is_valid_template(template) {
    return (is_struct(template)
        && template.__type == "object_template"
        && template.__version == 1
        && object_exists(template.object_index)
        && is_struct(template.variables));
}
function create_from_template(template, x, y, layer, team) {

    //show_message(template)
    // Создаем экземпляр
    var inst = instance_create_layer(x, y, layer, template.reff.object_index, {team: team});

    if (!instance_exists(inst)) return noone;

    // Устанавливаем переменные
    var vars = template.reff.variables;
    var var_names = variable_struct_get_names(vars);
    
    for (var i = 0; i < array_length(var_names); i++) {
        var name = var_names[i];
        if (variable_instance_exists(inst, name)) {
            inst[$ name] = vars[$ name];
        }
    }

    return inst;}