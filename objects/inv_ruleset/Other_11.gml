team = 2 
    global.layout_t1  = [[], [], []]
    global.not_sorted_t1 = []
    for (var i = 0; i < array_length(global.layout[1]); i++){
        for (var j = 0; j < array_length(global.layout[1][i]); j++){
            var a = instance_create_layer(228 + 256 * (2-i) + 128 * floor(j / 6), 0 + 128 * (j % 6), "Instances", pre_fight_hero, {type: global.layout[1][i][j], equipped: 3 - i})
            with a {array_push(global.layout_t1[i], self)}}
}    for (var i = 0; i < array_length(global.not_sorted[1]); i++){
        var a = instance_create_layer(128 + 925 + 128 * (i % 3), 64 + 128 * floor(i / 3), "Instances", pre_fight_hero, {type: global.not_sorted[1][i], equipped: 0})
        with a {array_push(global.not_sorted_t1, self)}
}
drag_obj = noone
with pre_fight_hero{
    if self == global.char_to_show{
        reff = global.char_to_show.reff
    } 
        }    