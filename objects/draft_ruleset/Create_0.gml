global.chars = [[], []]
global.charlist = [sp_hero]
global.draftlist = []
allow_copy = 1
for (var i=0; i<array_length(global.charlist); i++){
    var a = instance_create_depth(512+(i%5)*64, 64+floor(i/5)*128, -100, avatar)
    a.sprite_index = global.charlist[i]
    a.image_xscale = 0.7
    a.image_yscale = 0.7
    array_push(global.draftlist, a)
}
turn = 1
full = false