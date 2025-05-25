draw_self(); // Базовая отрисовка

// Позиционирование в центре экрана
var xx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
var yy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 3;

// Анимация появления
var current_alpha = ease_out_quad(animation_progress);
var current_scale = lerp(0.8, 1.2, ease_out_back(animation_progress));

// Фон баннера
draw_sprite_ext(spr_banner_bg, 0, xx, yy, current_scale, current_scale, 0, c_white, current_alpha);

// Отрисовка иконок с анимацией
var icon_spacing = banner_width / (3 + array_length(assist_sprites));

// 1. Иконка убийцы (появляется первой)
if (animation_progress > 0.2) {
    var killer_alpha = min(1, (animation_progress - 0.2) * 2);
    draw_sprite_ext(killer_sprite, 0, 
                   xx - icon_spacing, yy, 
                   icon_size/128, 
                   icon_size/128,
                   0, c_white, killer_alpha);
}

// 2. Иконка жертвы с зачеркиванием (появляется второй)
if (animation_progress > 0.4) {
    var victim_alpha = min(1, (animation_progress - 0.4) * 2);
    draw_sprite_ext(victim_sprite, 0, 
                   xx + icon_spacing, yy, 
                   icon_size/128, 
                   icon_size/128,
                   0, c_white, victim_alpha);
    
    // Зачеркивающая линия
    if (animation_progress > 0.6) {
        var strike_alpha = min(1, (animation_progress - 0.6) * 3);
        draw_set_color(make_color_rgb(255, 50, 50));
        draw_set_alpha(strike_alpha);
        draw_line_width(
            xx + icon_spacing - icon_size/2, yy - icon_size/2,
            xx + icon_spacing + icon_size/2, yy + icon_size/2,
            strike_width
        );
        draw_set_alpha(1);
    }
}

// 3. Иконки помощников (появляются последними)
for (var i = 0; i < array_length(assist_sprites); i++) {
    if (animation_progress > 0.5 + i*0.1) {
        var assist_alpha = min(1, (animation_progress - (0.5 + i*0.1)) * 2);
        var assist_x = xx + icon_spacing*(i + 2);
        draw_sprite_ext(assist_sprites[i], 0, 
                       assist_x, yy, 
                       icon_size/128, 
                       icon_size/128,
                       0, c_white, assist_alpha);
    }
}

// Текст убийства (с анимацией)
if (animation_progress > 0.7) {
    var text_alpha = min(1, (animation_progress - 0.7) * 3);
    var kill_text = get_kill_text(kill_type);
    var text_width = string_width(kill_text);
    
    // Эффект "удара" текста
    var text_scale = 1 + 0.2 * sin(animation_progress * 20);
    
    draw_set_font(fnt_kill_banner);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Тень текста
    draw_set_color(c_black);
    draw_set_alpha(0.7)
    draw_text_ext_transformed(xx + 3, yy + icon_size + 23 + 3, 
                            kill_text, -1, 500, text_scale, text_scale, 0);
    
    // Основной текст
    draw_set_color(get_kill_color(kill_type));
    draw_set_alpha(1)
    draw_text_ext_transformed(xx, yy + icon_size + 23, 
                            kill_text, -1, 500, text_scale, text_scale, 0);
}