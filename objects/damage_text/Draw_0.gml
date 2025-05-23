// Установка цвета и альфа-канала
draw_set_alpha(alpha);
draw_set_color(color);
draw_set_font(fnt_focus); // Используем специальный шрифт

// Рисуем текст с масштабом и центрированием
draw_text_ext_transformed(
    x, y,
    text,
    -1, 500, // Масштаб X и Y
    scale,            // Угол поворота
    scale, alpha
);

// Возвращаем стандартные настройки
draw_set_alpha(1);
draw_set_color(c_white);