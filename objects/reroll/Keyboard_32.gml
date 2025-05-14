//global.loot[loot_ruleset.team-1] = chest.drop
chest.drop = noone
chest.can_roll = true
chest.rolling_items = []
chest.rolling = 0
chest.rolling_items = []
chest.time = 30
chest.chestt = "basic"
chest.sspeed = random_range(25, 30)
chest.a = random_range(-0.07, -0.05)
chest.new_r = (room_width + 128 / chest.sspeed)
chest.sprite_index = chest_closed
instance_destroy(chest.s)
instance_destroy(self)