use_skill(target, true, {sub_target_modifer: damage_to_targets[0]});
for (var j = 0; j < array_length(sub_targets); j++){
    use_skill(sub_targets[j], false, {sub_target_modifer: damage_to_targets[j+1]})
}
// Сброс перезарядки
cd = cooldown * (1 + random_range(-0.1, 0.1)); // ±10% разброс
ready = false;