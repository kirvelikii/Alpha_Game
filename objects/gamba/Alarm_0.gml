if rarity == "common"{
    col = c_ltgray}
if rarity == "uncommon"{
    col = c_lime}
if rarity == "rare"{
    col = c_blue}
if rarity == "epic"{
    col = make_color_rgb(171, 29, 173)}
if rarity == "legendary"{
    col = c_yellow}
if rarity == "mythic"{
    col = c_red
}
chest.col = col