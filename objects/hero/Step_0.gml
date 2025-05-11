attack_cooldown -= 1;

if (attack_cooldown <= 0) {
    // Случайный разброс интервала атаки (±20% от базового)
    attack_cooldown = attack_interval * (0.8 + random(0.4));
    
    if (!instance_exists(target)) {
        find_basic_target();
    }
    
    if (instance_exists(target)) {
        attack(target);
        
        // 10% шанс сменить цель после атаки
        if (irandom(100) < 10) {
            find_basic_target();
        }
    }
}

if (hp <= 0) {
    instance_destroy();
    ruleset.check_win();
}