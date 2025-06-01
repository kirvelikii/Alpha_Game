// Рисуем все активные сообщения
var start_y = 1000; // Стартовая позиция Y
var start_y_feed = 1000; // Стартовая позиция Y
for (var i = 0; i < array_length(messages); i++) {
    var msg = messages[i];
    if msg.type == "kill"{
    // Прозрачность (плавое исчезновение)
    var alpha = clamp(msg.timer / 30, 0, 1); // Последние 30 кадров - fade-out
    
    // Фон сообщения
    draw_set_font(fnt_result)
    draw_set_alpha(alpha * 0.6);
    draw_rectangle(0, start_y, 500, start_y + 80, false);
    draw_set_alpha(1);
    
    // Иконка убийцы
    draw_sprite_ext(msg.killer_sprite, 1, 0, start_y + 10, 0.5, 0.5, 0, c_white, alpha);
    draw_set_halign(fa_left)
    draw_text_transformed_color(100, start_y, msg.kiler_name, 1, 1, 0, c_red, c_red, c_red, c_red, alpha);
    draw_set_halign(fa_center)
    draw_text_transformed_color(250, start_y + 25, msg.text, 1, 1, 0, c_red, c_red, c_red, c_red, alpha);
    draw_set_halign(fa_right)
    draw_text_transformed_color(400, start_y + 45, msg.victim_name, 1, 1, 0, c_red, c_red, c_red, c_red, alpha);
    // Иконка жертвы
    draw_sprite_ext(msg.victim_sprite, 0, 436, start_y + 10, 0.5, 0.5, 0, c_white, alpha);
    
    start_y -= 80 + spacing;}
}
for (var i = 0; i < array_length(feed); i++) {
    var msg = feed[i];
    if msg.type == "flood"{
        var alpha = clamp(msg.timer / 30, 0, 1); // Последние 30 кадров - fade-out
    
    // Фон сообщения
    draw_set_font(fnt_result)
    draw_set_alpha(alpha * 0.6);
    draw_rectangle(1549, start_y_feed, 2049, start_y_feed + 80, false);
    draw_set_alpha(1);
    
    // Иконка убийцы
    draw_sprite_ext(msg.killer_sprite, 1, 2049, start_y_feed + 10, -0.5, 0.5, 0, c_white, alpha);
    draw_set_halign(fa_center)
    draw_text_transformed_color(2049-250, start_y_feed, msg.kiler_name, 1, 1, 0, c_yellow, c_yellow, c_yellow, c_yellow, alpha);
    draw_text_ext_transformed_color(2049-250, start_y_feed + 25, msg.text, -1, 400, 1, 1, 0, c_white, c_white, c_white, c_white, alpha);
    
    start_y_feed -= 80 + spacing;
}}
