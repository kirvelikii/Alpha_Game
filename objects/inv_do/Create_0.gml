drag_obj = noone
//global.chars = [["starter", "starter", "starter"], ["starter", "starter", "starter"]]
//global.loot = [[], []]
//global.lootobj = [[], []]
//global.equips = [[[], [], []], [[], [], []]]
team = 1
for (var i = 0; i < array_length(global.chars); i++){
    a = instance_create_depth(0, 256 * i, 200, eq_char)
    a.sprite_index = global.chars[team-1][i].sprite_index
    a.name = (global.chars[team-1][i].name)
}
//show_message(asset_get_index(global.loot[0][0]))
global.lootobj = [[],[]]
for (var i = 0; i<array_length(global.loot[team-1]); i++){
    var o = instance_create_depth(768 + i % 8 * 64 + 10, 60 + 64 * floor(i/8), 0, item)
    o.sprite_index = asset_get_index(global.loot[team-1][i])
    o.mask_index = asset_get_index(global.loot[team-1][i])
    o.image_xscale = 0.5
    o.image_yscale = 0.5
    o.name = string(sprite_get_name(o.sprite_index))
    array_push(global.lootobj[team-1], o)
}
for (var i = 0; i<array_length(global.equips[team-1]); i++){
    for (var j = 0; j<array_length(global.equips[team-1][i]); j++){
    var o = instance_create_depth(128 + (j % 10) * 64, 256 * i + 64 * floor(j/10), 0, item)
    o.sprite_index = asset_get_index(global.equips[team-1][i][j].name)
    o.mask_index = asset_get_index(global.equips[team-1][i][j].name)
    o.image_xscale = 0.5
    o.image_yscale = 0.5
    o.name = string(sprite_get_name(o.sprite_index))
    o.equipped = i+1    
}}
function check_spaces_eq(equipped){
    for (var i=0; i<array_length(global.equips[team-1][equipped-1]); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
        global.equips[team-1][equipped-1][i].x = 128 + 64 * (i % 10)
        global.equips[team-1][equipped-1][i].y =  (equipped-1) * 256 + 64 * floor(i / 10) 
    }
}
function check_spaces(){
        for (var i=0; i<array_length(global.lootobj[team-1]); i++){
        //show_message(global.equips[inv_ruleset.team-1][equipped-1][i])
        global.lootobj[team-1][i].x = 768 + 64 * (i % 8)
        global.lootobj[team-1][i].y = 60 + 64 * floor(i / 8)
    }
}