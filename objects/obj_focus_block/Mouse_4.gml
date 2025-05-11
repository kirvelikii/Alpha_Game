if (!focus_unlocked && can_unlock()) {
    focus_unlocked = true;
    global.player_exp -= focus_cost;
    //apply_effects();
    
    // Корректное обновление статуса через вызов функции
    var updated = starter_tree.update_focus_status(focus_id, true);
}
