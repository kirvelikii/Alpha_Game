randomize()
if !rolling and drop == noone{
    rolling = 1
    global.rolls[loot_ruleset.team-1] -= 1
    instance_create_depth(x + 300 - 4, y - 400, -100, win_st)
    sprite_index = chest_opened
}