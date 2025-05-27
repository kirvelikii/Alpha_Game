global.chosen_pers = noone
opened = false
instance_create_layer(1950, 1088, "UI", close)
function calculate_kda(kills, deaths, assists) {
    //if (deaths == 0) deaths = 1; // Чтобы избежать деления на 0
    return (kills + assists) / (deaths + 1);
}
function calculate_mvp_score(player) {
    var kda_score = calculate_kda(player.statistics.kda_last.kills, player.statistics.kda_last.deaths, player.statistics.kda_last.assists)
    var damage_score = player.statistics.damage.last / 100; // 150 урона = 1 балл
    var damage_taken_score = (player.statistics.damage_taken.last / player.max_hp) * 2; // больше урона = лучше
    //var objectives_score = player.objectives * 2; // Участие в убийствах объектов
    
    return kda_score + damage_score + damage_taken_score
}
tops1 = [] 
tops2 = []
with hero{
        var scor = other.calculate_mvp_score(self)
        ti = uid
        if team == 1{
            var in = array_find_index(other.tops1, function f(a){if a[0].uid == other.ti return true else return false})
            if in == -1{
                 array_push(other.tops1, [self, scor, uid])
            }
            else{
                other.tops1[in][1] = scor
            }
        }
        else {
            array_push(other.tops2, [self, scor, uid])
        }    
    }
    array_sort(tops1, function (a, b) {return a[1] < b[1]})
    array_sort(tops2, function (a, b) {return a[1] < b[1]})

function draw_horizontal_healthbar(_x1 = x, _x2 = x + 128, _y1 = y, _y2 = y + 10 * image_yscale, wid = 128) {
    /* Параметры:
       _x1, _y1 - левый верхний угол
       _x2, _y2 - правый нижний угол
       wid - ширина шкалы (по умолчанию 128) */
    var hp_drain_speed = 1
    // Фон шкалы (черная рамка с красными краями)
    draw_rectangle_color(_x1, _y1, _x2, _y2, c_black, c_red, c_red, c_red, false);
    
    // Плавное изменение отображаемого здоровья
    current_hp_display = lerp(current_hp_display, global.chosen_pers.hp, 0.1 * hp_drain_speed);
    
    // Рассчитываем ширину
    var display_width = wid * (current_hp_display / global.chosen_pers.max_hp);
    var real_width = wid * (global.chosen_pers.hp / global.chosen_pers.max_hp);
    
    // Индикатор урона (желтый)
    if (current_hp_display > global.chosen_pers.hp) {
        var damage_width = display_width - real_width;
        draw_rectangle_color(
            _x1 + real_width, _y1,
            _x1 + real_width + damage_width, _y2,
            global.chosen_pers.damage_color, global.chosen_pers.damage_color, global.chosen_pers.damage_color, global.chosen_pers.damage_color, false
        );
    }
    
    // Основная зеленая часть
    draw_rectangle_color(
        _x1, _y1,
        _x1 + real_width, _y2,
        c_green, c_green, c_lime, c_green, false
    );
    
    // Индикатор лечения (голубой)
    if (current_hp_display < global.chosen_pers.hp) {
        var heal_width = real_width - display_width;
        draw_rectangle_color(
            _x1 + display_width, _y1,
            _x1 + display_width + heal_width, _y2,
            global.chosen_pers.heal_color, global.chosen_pers.heal_color, global.chosen_pers.heal_color, global.chosen_pers.heal_color, false
        );
    }
    
    // Анимация пульсации при полном здоровье
    if (global.chosen_pers.hp >= global.chosen_pers.max_hp) {
        var pulse = 0.3 + 0.1 * sin(current_time * 0.01);
        draw_set_alpha(pulse);
        draw_rectangle_color(
            _x1, _y1,
            _x1 + real_width, _y2,
            c_green, c_green, c_white, c_lime, false
        );
        draw_set_alpha(1);
    }
    
    // Тонкая белая рамка
    //draw_rectangle(_x1, _y1, _x2, _y2, false);
}
function draw_horizontal_sanitybar(_x1 = x, _x2 = x + 128, _y1 = y, _y2 = y + 10 * image_yscale, wid = 128) {
    /* Параметры:
       _x1, _y1 - левый верхний угол
       _x2, _y2 - правый нижний угол
       wid - ширина шкалы (по умолчанию 128) */
    var hp_drain_speed = 1
    // Фон шкалы (черная рамка с красными краями)
    draw_rectangle_color(_x1, _y1, _x2, _y2, c_black, c_blue, c_blue, c_blue, false);
    
    // Плавное изменение отображаемого здоровья
    current_sanity_display = lerp(current_sanity_display, global.chosen_pers.sanity, 0.1 * hp_drain_speed);
    
    // Рассчитываем ширину
    var display_width = wid * (current_sanity_display/ global.chosen_pers.max_sanity);
    var real_width = wid * (global.chosen_pers.sanity / global.chosen_pers.max_sanity);
    if real_width < 0{real_width = 0}
    if display_width < 0{display_width = 0}    
    
    // Индикатор урона (желтый)
    if (current_sanity_display > global.chosen_pers.sanity) {
        var damage_width = display_width - real_width;
        draw_rectangle_color(
            _x1 + real_width, _y1,
            _x1 + real_width + damage_width, _y2,
            c_red, c_red, c_red, c_red, false
        );
    }
    var pink = make_color_rgb(128, 0, 128)
    // Основная зеленая часть
    draw_rectangle_color(
        _x1, _y1,
        _x1 + real_width, _y2,
        pink, pink, c_purple, pink, false
    );
    
    // Индикатор лечения (голубой)
    if (current_sanity_display < global.chosen_pers.sanity) {
        var heal_width = real_width - display_width;
        draw_rectangle_color(
            _x1 + display_width, _y1,
            _x1 + display_width + heal_width, _y2,
            c_white, c_white, c_white, c_white, false
        );
    }
    
    // Анимация пульсации при полном здоровье
    if (global.chosen_pers.sanity >= global.chosen_pers.max_sanity) {
        var pulse = 0.3 + 0.1 * sin(current_time * 0.01);
        draw_set_alpha(pulse);
        draw_rectangle_color(
            _x1, _y1,
            _x1 + real_width, _y2,
            pink, pink, c_white, c_white, false
        );
        draw_set_alpha(1);
    }
    
    // Тонкая белая рамка
    //draw_rectangle(_x1, _y1, _x2, _y2, false);
}
schet = [0, 0]
function aas(a, b) {
    // Сравнение первого ключа
    if (a[1] > b[1]) return -1;
    if (a[1] < b[1]) return 1;
    
    // При равенстве первого ключа - сравнение второго
    if (a[2] > b[2]) return -1;
    if (a[2] < b[2]) return 1;
    
    return 0; // Полное равенство
};