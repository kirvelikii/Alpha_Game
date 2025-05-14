chest.drop = instance_place(x, y - 20, gamba).type
//show_message(drop)
with(chest){
    event_user(0)
    rolling = 0
}
instance_destroy(self)