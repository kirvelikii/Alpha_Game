if inv_ruleset.page != "chars"{
inv_ruleset.page = "chars"
for (var i = 0; i < array_length(global.not_sorted[inv_ruleset.team-1]); i++){
    var a = instance_create_layer(925 + 128 * (i % 3) + (inv_ruleset.team - 1) * 128, 64 + 128 * floor(i / 3), "Instances", pre_fight_hero, {type: global.not_sorted[inv_ruleset.team-1][i], equipped: 0})
    with a {array_push(global.not_sorted_t1, self)}
} 
    global.not_sorted[inv_ruleset.team-1] = []
}
image_blend = c_white
depth = -50
equips_panel.image_blend = c_gray
equips_panel.depth = 0
for (var i=0; i<array_length(global.items); i++){
    array_push(global.items_non_equipped[inv_ruleset.team-1], global.items[i].data)
    instance_destroy(global.items[i])
}
global.items = []
inv_ruleset.check_spaces()