var delete_n = []
potency = 0
for (var i = 0; i< array_length(stacks); i++){
    stacks[i].duration -= 1
    if stacks[i].duration <= 0{
        array_push(delete_n, i)
    }
    else{
        potency += stacks[i].potency
    }
}
for (var i = 0; i<array_length(delete_n); i++){
    array_delete(stacks, delete_n[i], 1)
}
if array_length(stacks) == 0 and instance_exists(host){
    array_delete(host.statuses_visual, array_get_index(host.statuses_visual, self), 1)
    instance_destroy()
}
if instance_exists(host){
    number = array_get_index(host.statuses_visual, self)
x = host.x + (image_xscale * 32 * number) % 128
y = host.y + 96 - floor(32 * number / 128) * 32
}
