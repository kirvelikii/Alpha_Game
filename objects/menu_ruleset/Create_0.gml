/*char_list = ["starter", "warrior"]
sprite_list = ["idle", "combat", "clash", "damage", "win", "fallen"]
char1 = char_list[irandom(array_length(char_list) - 1)]
char2 = char_list[irandom(array_length(char_list) - 1)]
sprite1 = sprite_list[irandom(array_length(sprite_list) - 1)]
sprite2 = sprite_list[irandom(array_length(sprite_list) - 1)]
//show_message([char1, sprite1, char2, sprite2])*/
time = 0
colors = [
    make_color_rgb(128, 0, 0),
    make_color_rgb(128, 128, 0),  
    make_color_rgb(0, 128, 0),
    make_color_rgb(0, 128, 128),  
    make_color_rgb(0, 0, 128),
    make_color_rgb(128, 0, 128)
];
randomize()
current_angle = 0;
rotation_speed = 0.5; // Скорость вращения (градусов за шаг)
gradient_size = 0.3; 
var w = room_width;
var h = room_height;
gradient_surface = surface_create(w, h);
function get_gradient_color(angle) {
    angle = angle % 360;
    var angle_step = 360 / array_length(colors);
    var color_idx = floor(angle / angle_step) % array_length(colors);
    var next_idx = (color_idx + 1) % array_length(colors);
    var blend = (angle % angle_step) / angle_step;
    
    return make_color_rgb(
        lerp(color_get_red(colors[color_idx]), color_get_red(colors[next_idx]), blend),
        lerp(color_get_green(colors[color_idx]), color_get_green(colors[next_idx]), blend),
        lerp(color_get_blue(colors[color_idx]), color_get_blue(colors[next_idx]), blend)
    );
}
function draw_gradient_rotated(angle) {
    var w = room_width;
    var h = room_height;
    var center_x = w/2;
    var center_y = h/2;
    var max_dist = point_distance(0, 0, center_x, center_y);
    // Оптимизация: рисуем через surface для плавности
    if (!surface_exists(gradient_surface)) {
        gradient_surface = surface_create(w, h);
    }
    surface_set_target(gradient_surface);
    draw_clear_alpha(c_black, 0);
    // Рисуем градиентные круги
    var steps = 36;
    var step_angle = 360 / steps;
    for (var i = 0; i < steps; i++) {
        var a1 = angle + i * step_angle;
        var a2 = angle + (i + 1) * step_angle;
        
        var col1 = get_gradient_color(a1);
        var col2 = get_gradient_color(a2);
        
        // Рассчитываем вершины сектора
        var x1 = center_x + lengthdir_x(max_dist, a1);
        var y1 = center_y + lengthdir_y(max_dist, a1);
        var x2 = center_x + lengthdir_x(max_dist, a2);
        var y2 = center_y + lengthdir_y(max_dist, a2);
        
        // Рисуем градиентный треугольник
        draw_primitive_begin(pr_trianglestrip);
        draw_vertex_color(center_x, center_y, col1, 1);
        draw_vertex_color(x1, y1, col1, 1);
        draw_vertex_color(center_x, center_y, col2, 1);
        draw_vertex_color(x2, y2, col2, 1);
        draw_primitive_end();
    }
    surface_reset_target();
    draw_surface(gradient_surface, 0, 0);
}
curr_state = "main"
function check_state(st){
    if curr_state == "main"{
        with exitt{
            instance_destroy()
        }
        with start{
            instance_destroy()
        }
    }
    else if curr_state == "mode_choose"{
        with duel{
            instance_destroy()
        }
        with back{
            instance_destroy()
        }
    }
    curr_state = st
    if st == "mode_choose"{
        instance_create_layer(480, 224, "Instances", duel)
        instance_create_layer(480, 608, "Instances", back)
    }
    else if st == "main"{
        instance_create_layer(480, 224, "Instances", start)
        instance_create_layer(480, 608, "Instances", exitt)
    }
}