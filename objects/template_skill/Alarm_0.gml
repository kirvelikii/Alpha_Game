var can_cast = true;

// Проверяем все ограничения
for (var i = 0; i < array_length(restrictions); i++) {
    if (!check_restriction(restrictions[i])) {
        can_cast = false;
        break;
    }
}
if (can_cast) {
    find_target(1);
    // Добавляем задержку перед анимацией эффекта
    if (instance_exists(target)) {
        show_effect(target, eff);
        alarm[1] = animation_delay;
    }
}