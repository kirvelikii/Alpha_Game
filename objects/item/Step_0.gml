// В Step Event перетаскиваемого объекта
if (is_dragging){
    // Обновляем позицию с учетом смещения
    x = mouse_x + drag_offset_x;
    y = mouse_y + drag_offset_y;
    
    // Ограничение по границам комнаты (опционально)
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
}
if (!is_dragging) {
    x = round(x/64)*64; // Привязка к сетке 32px
    y = round(y/64)*64;
}

if is_dragging{
        
}