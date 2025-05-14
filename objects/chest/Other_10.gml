//drop = sprite_get_name(drop)
for (var i=0; i<array_length(rolling_items); i++){
    instance_destroy(rolling_items[i])
}
if drop !=noone{
    s = instance_create_layer(x + 256 - 64, y - 400, "Instances", gamba)
    s.sprite_index = asset_get_index(drop.texture)
    s.mask_index = asset_get_index(drop.texture)
    //show_message(drop)
    s.rarity = drop.rarity
    //show_message(global.loot)
    array_push(global.loot[loot_ruleset.team-1], drop)
}
instance_create_depth(x + 256, y - 200, -200, reroll)
rolling = 0
