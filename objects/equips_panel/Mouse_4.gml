if inv_ruleset.page != "items"{
    inv_ruleset.page = "items"
global.not_sorted[inv_ruleset.team-1] = []
for (var i = 0; i < array_length(global.not_sorted_t1); i++){
        array_push(global.not_sorted[inv_ruleset.team-1], global.not_sorted_t1[i])
        instance_destroy(global.not_sorted_t1[i])
}
        global.not_sorted_t1 = []
}
image_blend = c_white
depth = -50
chars_panel.image_blend = c_gray
chars_panel.depth = 0
for (var i = 0; i < array_length(global.items_non_equipped[inv_ruleset.team - 1]); i++){
        var a = instance_create_layer(925 + 64 * (i % 6), 64 + 64 * floor(i / 6), "Instances", item, {data: global.items_non_equipped[inv_ruleset.team - 1][i]})
        with a {array_push(global.items, self)}
        //array_delete(global.items_non_equipped[inv_ruleset.team - 1], i, 1)
}
global.items_non_equipped[inv_ruleset.team - 1] = []
inv_ruleset.check_spaces_inv()