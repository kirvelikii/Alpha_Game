if type == "basic"{
if instance_exists(host){
    x = host.x - 128 * image_xscale
    y = host.y
}}
else if type == "projectile"{
    if is_launched{
        x += velocity_x;
        y += velocity_y;
    
    // Применяем гравитацию
    //velocity_y += gravityy;
    
    // Правильный поворот с учетом направления
    var move_angle = arctan2(-1 * velocity_y, velocity_x);
        //show_message(move_angle)
    image_angle = radtodeg(move_angle)
    if (x - target_x) * sign(velocity_x) >= 0{
        is_launched = false
        sprite_index = st.land_eff
        alarm[0] = st.land_dl
    }
    
}}