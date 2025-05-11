drop = sprite_get_name(drop)
for (var i=0; i<array_length(rolling_items); i++){
    instance_destroy(rolling_items[i])
}
if !rolling and drop !=noone{
    s = instance_create_layer(x + 256 - 64, y - 400, "Instances", gamba)
    s.sprite_index = asset_get_index(drop)
    s.mask_index = asset_get_index(drop)
    s.rarity = global.items_db[$ drop].rarity
    //show_message(global.loot)
    array_push(global.loot[loot_ruleset.team-1], sprite_get_name(s.sprite_index))
}
instance_create_depth(x + 256, y - 200, -200, reroll)
