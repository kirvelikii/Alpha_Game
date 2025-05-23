animation_length = sprite_get_number(sprite_index) / sprite_get_speed(sprite_index);
//image_speed = sprite_get_speed(sprite_index)
alarm[0] = animation_length;
if !variable_instance_exists(self, "hero"){
    host = instance_place(x, y, hero)
}
x-=128 * image_xscale