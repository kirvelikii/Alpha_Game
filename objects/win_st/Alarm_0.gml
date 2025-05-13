chest.drop = instance_place(x, y - 20, gamba).type
with(chest){
    event_user(0)
}
instance_destroy(self)