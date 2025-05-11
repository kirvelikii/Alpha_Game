if !ban and !draft_ruleset.full and no==0{
var a = instance_create_depth(0 + (room_width) * (draft_ruleset.turn - 1), array_length(global.chars[draft_ruleset.turn-1]) * 256, -100, avatar)
a.sprite_index = sprite_index
a.no = true  
array_push(global.chars[draft_ruleset.turn-1], asset_get_index(string_replace(sprite_get_name(a.sprite_index), "sp_", "")))
if !draft_ruleset.allow_copy{
    image_blend = c_dkgray
    ban = true
}
    if draft_ruleset.turn == 1{
        draft_ruleset.turn = 2
    }
    else{
        a.image_xscale = -1
        draft_ruleset.turn = 1
    }
}