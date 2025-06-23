    with(army){
        instance_destroy()
    }
var bl_c = 0
var red_c = 0
if global.mappos + 5 == chosen_map{
    instance_create_layer(10, 30, "Instances", army, {sprite_index: Sprite87, name:"Основная армия красных", c: c_red, side: "red"})
    instance_create_layer(356 + 256 * 2 - 42, 30, "Instances", army, {sprite_index: Sprite87, name:"Основная армия синих", c: c_blue, side: "blue"})
    var bl_c = 1
    var red_c = 1
}
for (var i = 0; i<array_length(global.map[chosen_map][1]); i++){
    if global.map[chosen_map][1][i].side == "red" or (team == 2 and global.map[chosen_map][1][i].side == "neutral"){
        instance_create_layer(10 + 32 * (bl_c % 12), 30 + 32 * floor(bl_c/12), "Instances", army, {sprite_index: global.map[chosen_map][1][i].sprite, name:global.map[chosen_map][1][i].name, c: global.map[chosen_map][1][i].color, side: global.map[chosen_map][1][i].side})
        bl_c += 1
    }
    if global.map[chosen_map][1][i].side == "blue" or (team == 1 and global.map[chosen_map][1][i].side == "neutral"){
        instance_create_layer(356 + 256 * 2 - 42 - 32 * (red_c % 12), 30 + 32 * floor(red_c/12), "Instances", army, {sprite_index: global.map[chosen_map][1][i].sprite, name:global.map[chosen_map][1][i].name, c: global.map[chosen_map][1][i].color, side: global.map[chosen_map][1][i].side})
        red_c += 1
    }
}