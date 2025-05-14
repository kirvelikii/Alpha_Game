
if !rolling and drop == noone and can_roll{
    randomize()
    rolling = 1
    can_roll = false
    global.rolls[loot_ruleset.team-1] -= 1
    instance_create_depth(x + 300 - 4, y - 400, -100, win_st)
    sprite_index = chest_opened
}