if type == "basic"{
animation_length = sprite_get_number(sprite_index) / sprite_get_speed(sprite_index);
//image_speed = sprite_get_speed(sprite_index)
if variable_struct_exists(st, "duration"){
    alarm[0] = st.duration
} 
    else{
        alarm[0] = animation_length;
    }

if !variable_instance_exists(self, "host"){
    host = instance_place(x, y, hero)
}
x-=128 * image_xscale}
else if type == "projectile"{
    mask_index = sprite_index
    image_xscale = 1
    x = st.source.x + 64 * st.source.image_xscale
    y = st.source.y + 64
    target_x = irandom_range(host.x + host.image_xscale * 32, host.x + host.image_xscale * 96);           // Координаты цели (устанавливаются при выстреле)
    target_y = irandom_range(host.y + 32, host.y + 96)
    var dx = target_x - x;
    var dy = target_y - y;
    max_speed = st.sspeed
    // Угол броска (в радианах)
    var dist = point_distance(0, 0, dx, dy);
    var angle = arctan2(dy, dx);
     
    // Корректировка угла с учетом гравитации (чем дальше цель, тем выше бросок)
    //var angle = base_angle - (dist / 1000);
    // Начальные скорости
    velocity_x = cos(angle) * max_speed;
    velocity_y = sin(angle) * max_speed;
    //show_message([velocity_x, velocity_y])
    // Запоминаем цель (опционально)
    //gravityy = 0.3;          // Сила гравитации (ускорение вниз)
    //max_speed = 15;         // Макс. скорость (регулирует "силу броска")
    is_launched = true;    // Флаг: запущена ли стрела
}