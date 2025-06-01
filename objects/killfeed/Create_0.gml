// Настройки панели
messages = []; // Массив сообщений
feed = []
max_messages = 5; // Макс. сообщений на экране
display_time = 10 * 60; // 5 секунд на сообщение
spacing = 5; // Отступ между сообщениями
function add_kill_message(_killer, _victim, _text="Убил") {
    var message = {
        killer_sprite: _killer.sprite_index, // Спрайт убийцы
        victim_sprite: _victim.sprite_index, // Спрайт жертвы
        kiler_name: _killer.nickname,
        victim_name: _victim.nickname,
        text: _text,
        timer: display_time,
        type: "kill"
    };
    
    // Добавляем в начало массива
    array_insert(messages, 0, message);
    
    // Ограничиваем количество сообщений
    if (array_length(messages) > max_messages) {
        array_resize(messages, max_messages);
    }
}
function add_message(_killer, _text="") {
    var message = {
        killer_sprite: _killer.sprite_index, // Спрайт убийцы // Спрайт жертвы
        kiler_name: _killer.nickname,
        text: _text,
        timer: display_time * 0.8,
        type: "flood"
    };
    
    // Добавляем в начало массива
    array_insert(feed, 0, message);
    
    // Ограничиваем количество сообщений
    if (array_length(feed) > max_messages) {
        array_resize(feed, max_messages);
    }
}