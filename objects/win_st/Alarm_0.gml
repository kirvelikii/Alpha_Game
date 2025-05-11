chest.drop = instance_place(x, y - 20, gamba).sprite_index
with(chest){
    event_user(0)
}
instance_destroy(self)