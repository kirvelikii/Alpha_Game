//show_message(global.loot)
//global.mode = "assync_mp"
global.mode = "duel"
if !variable_global_exists("mappos"){
    global.mappos = 0
    global.map = [["red", []], ["red", []], ["red", []], ["red", []], ["red", [{side: "neutral", name: "Нейтралитет", color: c_gray, sprite: Sprite87, type: "nope"}]], ["nobody", [{side: "blue", name: "Debug", color: c_white, sprite: Sprite24, type: "army", contains: [hero, hero, hero]}]], ["blue", []], ["blue", []], ["blue", []], ["blue", []], ["blue", []]]
}
if !variable_global_exists("round"){
    global.round = 0
}
global.round += 1
if !variable_global_exists("winner"){
    global.winner = noone
}
if !variable_global_exists("inv_team"){
     global.inv_team = 0
    global.char_to_show = noone
}
if !variable_global_exists("equipped_items"){
    global.equipped_items = [[], []]
}
if global.inv_team = 0{
    global.inv_team = 1
    global.loot = [[global.items_db.damage_up, global.items_db.first_strike_ult, global.items_db.armor_crusher, global.items_db.hero], [global.items_db.hero, global.items_db.damage_up, global.items_db.first_strike_ult, global.items_db.armor_crusher]]
if !variable_global_exists("not_sorted") and !variable_global_exists("layout"){
    global.layout = [[[], [archer], [warrior]], [[], [archer], [warrior]]]
    global.not_sorted = [[hero, hero, warrior, warrior], [hero, hero, warrior, warrior]]
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
        var a = instance_create_layer(228 + 256 * i - 128 * floor(j / 5), 128 + 128 * (j % 5), "Instances", pre_fight_hero, {type: global.layout[0][i][j], equipped: i + 1})
        with a {array_push(global.layout_t1[i], self)}}
}for (var i = 0; i < array_length(global.not_sorted[0]); i++){
    var a = instance_create_layer(925 + 128 * (i % 3), 64 + 128 * floor(i / 3), "Instances", pre_fight_hero, {type: global.not_sorted[0][i], equipped: 0})
    with a {array_push(global.not_sorted_t1, self)}
}
with pre_fight_hero{
    if global.char_to_show != noone and reff.variables.uid == global.char_to_show.reff.variables.uid{
        reff = global.char_to_show.reff
        global.char_to_show = noone
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
        global.layout_t1[equipped-1][i].x = 228 + 256 * (equipped-1) - 128 * floor(i / 5)
        global.layout_t1[equipped-1][i].y = 128 + 128 * (i % 5) 
    }}
    else{
        for (var i=0; i<array_length(global.layout_t1[3-equipped]); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
        global.layout_t1[3-equipped][i].x = 228 + 256 * (equipped - 1) - 128 * floor(i / 5)
        global.layout_t1[3-equipped][i].y = 128 + 128 * (i % 5) 
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
}
chosen_map = global.mappos + 5
if (global.round == 1){
    instance_create_depth(0, 0, 0, neutral_faction)
}
