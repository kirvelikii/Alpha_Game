//layer_force_draw_depth(true, -100)
time+=1
// В Step-событии:
current_angle += rotation_speed;
if (current_angle >= 360) current_angle -= 360;

var angle_step = 360 / array_length(colors);
var color_positions = array_create(4);
for (var i = 0; i < 4; i++) {
    color_positions[i] = (current_angle + i * angle_step) % 360;
}
draw_gradient_rotated(current_angle);


/*if time > 60 and time >= fps * 5{
    char1 = char_list[irandom(array_length(char_list) - 1)]
    char2 = char_list[irandom(array_length(char_list) - 1)]
    sprite1 = sprite_list[irandom(array_length(sprite_list) - 1)]
    sprite2 = sprite_list[irandom(array_length(sprite_list) - 1)]
    time = 0
}*/
//draw_sprite_ext(asset_get_index("sp_" + char1 + "_" + sprite1) , 1 , x + time * 0.6, y + 200, 3, 3, 0, c_white, 1 - time / (fps * 5))
//draw_sprite_ext(asset_get_index("sp_" + char2 + "_" + sprite2) , 1 , room_width - time * 0.6, y + 200, -3, 3, 0, c_white, 1 - time / (fps * 5))