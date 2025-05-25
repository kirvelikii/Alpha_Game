// В событии Create объекта obj_kill_banner:
killer_sprite = object_get_sprite(killer.type);      // Спрайт убийцы
victim_sprite = death      // Спрайт жертвы
sp_assists = []
for (var i = 0; i < array_length(assists); i++){
    if instance_exists(assists[i]){
        array_push(sp_assists, object_get_sprite(assists[i].type))
    }
}
assist_sprites = sp_assists; 
kill_type = "NORMAL";       // Тип убийства (FIRST_BLOOD, DOUBLE_KILL и т.д.)
animation_progress = 0;     // Прогресс анимации (0-1)
duration = 2.5;             // Длительность показа в секундах

// Настройки внешнего вида
banner_width = 300;         // Ширина баннера
icon_size = 64;             // Размер иконок
strike_width = 3; 
function get_kill_text(type) {
    switch (type) {
        case "FIRST_BLOOD": return "FIRST BLOOD";
        case "DOUBLE_KILL": return "DOUBLE KILL";
        case "TRIPLE_KILL": return "TRIPLE KILL";
        case "QUADRA_KILL": return "QUADRA KILL";
        case "PENTA_KILL":  return "PENTA KILL";
        default: return "ENEMY ELIMINATED";
    }
}

// Функция для получения цвета убийства
function get_kill_color(type) {
    switch (type) {
        case "FIRST_BLOOD": return c_red;
        case "DOUBLE_KILL": return c_yellow;
        case "TRIPLE_KILL": return make_color_rgb(255, 150, 50);
        case "QUADRA_KILL": return make_color_rgb(255, 50, 255);
        case "PENTA_KILL":  return make_color_rgb(255, 50, 50);
        default: return c_white;
    }
}

ease_out_quad = function(progress) {
    return -1 * progress * (progress - 2);
};

ease_out_back = function(progress) {
    var s = 1.70158;
    return ((progress = progress - 1) * progress * ((s + 1) * progress + s) + 1);
};