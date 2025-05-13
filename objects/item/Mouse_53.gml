if is_dragging{
    array_delete(global.items, floor((y - 64)/ 64) + floor((x - 925)/ 64), 1)
    inv_ruleset.check_spaces_inv()
}