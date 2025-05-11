it = instance_place(x, y, pre_fight_hero)
if it != noone and !chosing{
    it.x = x
    it.y = y
    chosing = true
    it.x = mouse_x - 32
    it.y = mouse_y - 32
}
else {
	chosing = false
}
