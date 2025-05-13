if (is_dragging){
    // Обновляем позицию с учетом смещения
    x = mouse_x + drag_offset_x;
    y = mouse_y + drag_offset_y;
    
    // Ограничение по границам комнаты (опционально)
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
}