if !variable_global_exists("inv_team"){
     global.inv_team = 0
    global.char_to_show = noone
}
if global.inv_team = 0{
    global.inv_team = 1
    global.loot = [[global.items_db.damage_up], [global.items_db.hero]]
if !variable_global_exists("not_sorted") and !variable_global_exists("layout"){
    global.layout = [[[hero], [hero], [hero]], [[hero], [hero], [hero]]]
    global.not_sorted = [[hero, hero, hero, hero], [hero, hero, hero, hero]]
}
if !variable_global_exists("items_non_equipped"){
    global.items_non_equipped = [[], []]
}
for (var i = 0; i < array_length(global.loot[0]); i++){
    if global.loot[0][i].type == "hero"{
        array_push(global.not_sorted[0], global.loot[0][i].obj)
    }
    else{
        array_push(global.items_non_equipped[0], global.loot[0][i])
    }
}
for (var i = 0; i < array_length(global.loot[1]); i++){
    if global.loot[1][i].type == "hero"{
        array_push(global.not_sorted[1], global.loot[1][i].obj)
    }
    else{
        array_push(global.items_non_equipped[1], global.loot[1][i])
    }
}
}
team = global.inv_team
//show_message(team)
page = "chars"
randomize()
if team = 1{
global.loot = [[], []]
global.layout_t1  = [[], [], []]
global.not_sorted_t1 = []
global.items= []
for (var i = 0; i < array_length(global.layout[0]); i++){
    for (var j = 0; j < array_length(global.layout[0][i]); j++){
        var a = instance_create_layer(228 + 256 * i - 128 * floor(j / 6), 0 + 128 * (j % 6), "Instances", pre_fight_hero, {type: global.layout[0][i][j], equipped: i + 1})
        with a {array_push(global.layout_t1[i], self)}}
}for (var i = 0; i < array_length(global.not_sorted[0]); i++){
    var a = instance_create_layer(925 + 128 * (i % 3), 64 + 128 * floor(i / 3), "Instances", pre_fight_hero, {type: global.not_sorted[0][i], equipped: 0})
    with a {array_push(global.not_sorted_t1, self)}
}
with pre_fight_hero{
    if self == global.char_to_show{
        reff = global.char_to_show.reff
    } 
        }    
}
else{
    event_user(1)
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
function check_spaces_inv(){
    //show_message(array_length(global.items))
    for (var i=0; i<array_length(global.items); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
            global.items[i].x = 925 + 64 * (i % 6)
            global.items[i].y = 64 + 64 * floor(i / 6)
    }
}