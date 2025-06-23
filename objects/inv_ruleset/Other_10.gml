if team == 1 and global.mode == "duel"{
    //show_message(team)
    with chars_panel{event_user(0)}    
    global.layout[0] = [[], [], []]
    global.not_sorted[0] = []
    for (var i = 0; i < array_length(global.layout_t1); i++){
        for (var j = 0; j < array_length(global.layout_t1[i]); j++){
            array_push(global.layout[0][i], global.layout_t1[i][j])
            instance_destroy(global.layout_t1[i][j])}
}    for (var i = 0; i < array_length(global.not_sorted_t1); i++){
        array_push(global.not_sorted[0], global.not_sorted_t1[i])
        instance_destroy(global.not_sorted_t1[i])
}
    with pre_fight_hero{
        instance_destroy()
    }
    global.char_to_show = noone
    team = 2 
    global.layout_t1  = [[], [], []]
    global.not_sorted_t1 = []
    for (var i = 0; i < array_length(global.layout[1]); i++){
        for (var j = 0; j < array_length(global.layout[1][i]); j++){
            var a = instance_create_layer(228 + 256 * (2-i) + 128 * floor(j / 5), 128 + 128 * (j % 5), "Instances", pre_fight_hero, {type: global.layout[1][i][j], equipped: 3 - i})
            with a {array_push(global.layout_t1[i], self)}}
}    for (var i = 0; i < array_length(global.not_sorted[1]); i++){
        var a = instance_create_layer(128 + 925 + 128 * (i % 3), 64 + 128 * floor(i / 3), "Instances", pre_fight_hero, {type: global.not_sorted[1][i], equipped: 0})
        with a {array_push(global.not_sorted_t1, self)}
} 
    with(army){
        instance_destroy()
    }
instance_create_layer(10, 30, "Instances", army, {sprite_index: Sprite87, name:"Основная армия красных", c: c_red, side: "red"})
instance_create_layer(356 + 256 * 2 - 42, 30, "Instances", army, {sprite_index: Sprite87, name:"Основная армия синих", c: c_blue, side: "blue"})
var bl_c = 1
var red_c = 1
for (var i = 0; i<array_length(global.map[global.mappos+5][1]); i++){
    if global.map[global.mappos+5][1][i].side == "red" or (team == 2 and global.map[global.mappos+5][1][i].side == "neutral"){
        instance_create_layer(10 + 32 * (bl_c % 12), 30 + 32 * floor(bl_c/12), "Instances", army, {sprite_index: global.map[global.mappos+5][1][i].sprite, name:global.map[global.mappos+5][1][i].name, c: global.map[global.mappos+5][1][i].color, side: global.map[global.mappos+5][1][i].side})
        bl_c += 1
    }
    if global.map[global.mappos+5][1][i].side == "blue" or (team == 1 and global.map[global.mappos+5][1][i].side == "neutral"){
        instance_create_layer(356 + 256 * 2 - 42 - 32 * (red_c % 12), 30 + 32 * floor(red_c/12), "Instances", army, {sprite_index: global.map[global.mappos+5][1][i].sprite, name:global.map[global.mappos+5][1][i].name, c: global.map[global.mappos+5][1][i].color, side: global.map[global.mappos+5][1][i].side})
        red_c += 1
    }
} chosen_map = global.mappos
drag_obj = noone
}
else{
    with chars_panel{event_user(0)}   
    global.layout[1] = [[], [], []]
    global.not_sorted[1] = []
    global.char_to_show = noone
    for (var i = 0; i < array_length(global.layout_t1); i++){
        for (var j = 0; j < array_length(global.layout_t1[i]); j++){
            array_push(global.layout[1][i], global.layout_t1[i][j])
            instance_destroy(global.layout_t1[i][j])}
}    for (var i = 0; i < array_length(global.not_sorted_t1); i++){
        array_push(global.not_sorted[1], global.not_sorted_t1[i])
        instance_destroy(global.not_sorted_t1[i])
}
}
if global.mode == "assync_mp"{
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
    var names = struct_get_names(save_data)
    global.layout[1] = save_data[$ string(global.round)][irandom(array_length((save_data[$ string(global.round)]))-1)]
    //show_message(global.layout[1])
    show_debug_message(array_length([global.layout[1]]))
    room = fight
}