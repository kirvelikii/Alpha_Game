if is_dragging{
    var f = function f(a){return a.uid == other.uid}
    var ind = array_find_index(global.items, f)
    array_delete(global.items, ind, 1)
    //array_delete(global.items, floor((y - 64)/ 64) + floor((x - 925)/ 64), 1)
    inv_ruleset.check_spaces_inv()
}