instance_destroy(a)
instance_destroy(b)
instance_destroy(c)
a = instance_create_depth(0, 0, 200, eq_char)
b = instance_create_depth(0, 256, 200, eq_char)
c = instance_create_depth(0, 512, 200, eq_char)
a.sprite_index = asset_get_index(global.chars[team-1][0] + "_avatar")
b.sprite_index = asset_get_index(global.chars[team-1][1] + "_avatar")
c.sprite_index = asset_get_index(global.chars[team-1][2] + "_avatar")
a.name = (global.chars[team-1][0])
b.name = (global.chars[team-1][1])
c.name = (global.chars[team-1][2])
//show_message(asset_get_index(global.loot[0][0]))
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