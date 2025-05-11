team = 1
randomize()
if !variable_global_exists("not_sorted") and !variable_global_exists("layout"){
    global.layout = [[[hero], [hero], []], [[hero], [hero], [hero]]]
    global.not_sorted = [[hero, hero, hero, hero], [hero, hero, hero, hero]]
}
global.layout_t1  = [[], [], []]
global.not_sorted_t1 = []
for (var i = 0; i < array_length(global.layout[0]); i++){
    for (var j = 0; j < array_length(global.layout[0][i]); j++){
        var a = instance_create_layer(228 + 256 * i - 128 * floor(j / 6), 0 + 128 * (j % 6), "Instances", pre_fight_hero, {type: global.layout[0][i][j], equipped: i + 1})
        with a {array_push(global.layout_t1[i], self)}}
}for (var i = 0; i < array_length(global.not_sorted[0]); i++){
    var a = instance_create_layer(925 + 128 * (i % 3), 64 + 128 * floor(i / 3), "Instances", pre_fight_hero, {type: global.not_sorted[0][i], equipped: 0})
    with a {array_push(global.not_sorted_t1, self)}
}
drag_obj = noone
function check_spaces_eq(equipped){
    if team == 1{
    for (var i=0; i<array_length(global.layout_t1[equipped-1]); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
        global.layout_t1[equipped-1][i].x = 228 + 256 * (equipped-1) - 128 * floor(i / 6)
        global.layout_t1[equipped-1][i].y = 128 * (i % 6) 
    }}
    else{
        for (var i=0; i<array_length(global.layout_t1[3-equipped]); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
        global.layout_t1[3-equipped][i].x = 228 + 256 * (equipped - 1) - 128 * floor(i / 6)
        global.layout_t1[3-equipped][i].y = 128 * (i % 6) 
    }
    }
}
function check_spaces(){
    if team == 1{
    for (var i=0; i<array_length(global.not_sorted_t1); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
            global.not_sorted_t1[i].x = 925 + 128 * (i % 3)
            global.not_sorted_t1[i].y = 64 + 128 * floor(i / 3)
    }}
    else{ 
        for (var i=0; i<array_length(global.not_sorted_t1); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
            global.not_sorted_t1[i].x = 128 + 925 + 128 * (i % 3)
            global.not_sorted_t1[i].y = 64 + 128 * floor(i / 3)
    }
}}