// Создаем структуры для хранения данных
inventory_system = {
    // Инвентарь текущего персонажа
    equipped_items: [],
    
    // Неэкипированные предметы и предметы других персонажей
    unequipped_items: [],
    
    // Настройки отображения
    ui: {
        x: 300, y: 100,
        width: 400, height: 500,
        scroll_position: 0,
        item_height: 96,
        scroll: [0, 0] ,
        drag: {
            active: false,
            list: -1,
            start_y: 0,
            start_scroll: 0
        },
        button_pressed: false
    },
    
    // Выбранный предмет
    selected_item: -1,
    selected_list: 0, // 0 - equipped, 1 - unequipped
}
// В событии Create объекта интерфейса
function inventory_init() {
    // Заполняем тестовыми данными
    for (var i = 0; i < array_length(global.char_to_show.reff.variables.equips); i++) {
        global.char_to_show.reff.variables.equips[i].owner = global.char_to_show
        array_push(inventory_system.equipped_items, global.char_to_show.reff.variables.equips[i]);
    }
    
    for (var i = 0; i < array_length(global.items_non_equipped[global.inv_team-1]); i++) {
        array_push(inventory_system.unequipped_items, global.items_non_equipped[global.inv_team-1][i]);
    }
    for (var i = 0; i < array_length(global.equipped_items[global.inv_team-1]); i++) {
        if global.equipped_items[global.inv_team-1][i].owner != global.char_to_show{
        array_push(inventory_system.unequipped_items, global.equipped_items[global.inv_team-1][i]);}
    }
}
inventory_init()
// Обновленная функция draw_items_list()
function draw_items_list(x, y, w, h, items, list_index) {
    var ui = inventory_system.ui;
    var visible_items = floor(h / ui.item_height);
    //show_message(visible_items)
    var scroll = ui.scroll[list_index];
    
    // Ограничиваем скролл
    scroll = clamp(scroll, 0, max(0, array_length(items) - visible_items));
    ui.scroll[list_index] = scroll;
    
    // Рамка списка
    draw_set_color(c_white);
    draw_rectangle(x, y, x + w - 15, y + h, true);
    
    // Область отрисовки предметов (с маской)
    gpu_set_scissor(x, y, w - 15, h);
    draw_set_halign(fa_left)
    // Отрисовка видимых предметов
    for (var i = 0; i < visible_items; i++) {
        var item_index = i + scroll;
        if (item_index >= array_length(items)) break;
        
        var item_y = y + i * ui.item_height;
        
        // Выделение выбранного предмета (исправленная логика)
        if (item_index == inventory_system.selected_item && 
            inventory_system.selected_list == list_index) {
            draw_set_color(c_yellow);
            draw_rectangle(x, item_y, x + w - 15, item_y + ui.item_height, true);
        }
        
        // Отрисовка предмета
        draw_set_color(c_white);
        draw_sprite_ext(items[item_index].texture, 0, x + 5, item_y + ui.item_height/4, 0.5, 0.5, 0, c_white, 1);
        draw_set_halign(fa_left)
        var text = items[item_index].name;
        if (items[item_index].owner != global.char_to_show and items[item_index].owner != noone) text += " (" + string(items[item_index].owner.reff.variables.name) + ")";
        draw_text(x, item_y + 10, text);
    }
    
    gpu_set_scissor(0, 0, 1366, 769);
    
    // Отрисовка скроллбара
    if (array_length(items) > visible_items) {
        draw_scrollbar(x + w - 15, y, 15, h, scroll, array_length(items), visible_items, list_index);
    }
}

// Обновленная часть inventory_handle_input() для выбора предметов:
if (mouse_check_button_pressed(mb_left)) {
    // Проверяем клик в левом списке (экипированные)
    if (point_in_rectangle(mouse_x, mouse_y, 
        inventory_system.ui.x + 10, inventory_system.ui.y + 40, 
        inventory_system.ui.x + inventory_system.ui.width - 25, inventory_system.ui.y + inventory_system.ui.height - 40)) {
        
        var rel_y = mouse_y - (inventory_system.ui.y + 40);
        var item_index = floor(rel_y / inventory_system.ui.item_height) + inventory_system.ui.scroll[0];
        
        if (item_index < array_length(inventory_system.equipped_items)) {
            inventory_system.selected_item = item_index;
            inventory_system.selected_list = 0;
        }
    }
    
    // Проверяем клик в правом списке (неэкипированные)
    if (point_in_rectangle(mouse_x, mouse_y, 
        inventory_system.ui.x + inventory_system.ui.width + 20, inventory_system.ui.y + 40, 
        inventory_system.ui.x + 2*inventory_system.ui.width - 5, inventory_system.ui.y + inventory_system.ui.height - 40)) {
        
        var rel_y = mouse_y - (inventory_system.ui.y + 40);
        var item_index = floor(rel_y / inventory_system.ui.item_height) + inventory_system.ui.scroll[1];
        
        if (item_index < array_length(inventory_system.unequipped_items)) {
            inventory_system.selected_item = item_index;
            inventory_system.selected_list = 1;
        }
    }
}
function inventory_move_item() {
    if (inventory_system.selected_item == -1) return;
    
    var itemm;
    if (inventory_system.selected_list == 0) {
        // Снимаем предмет
        for (var i = 0; i <array_length(inventory_system.equipped_items); i++){
            if inventory_system.selected_item == i{
                itemm = inventory_system.equipped_items[i]
                itemm.owner = noone
                array_delete(inventory_system.equipped_items, i, 1);
                array_push(inventory_system.unequipped_items, itemm);
                array_push(global.items_non_equipped[global.inv_team-1], itemm)
                break
            }
        }
        for (var i = 0; i <array_length(global.equipped_items[global.inv_team - 1]); i++){
            if itemm == global.equipped_items[global.inv_team - 1][i]{
                array_delete(global.equipped_items[global.inv_team - 1], i, 1);
                break
            }
        }
        for (var ii = array_length(itemm.effect) - 1; ii >= 0; ii--){
                    if string_ends_with(itemm.effect[ii][0], "_perc"){
                        global.char_to_show.reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] /= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")])
                        global.char_to_show.reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] *= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] - itemm.effect[ii][1])
                        global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] -= itemm.effect[ii][1]
                       }
                    else{
                        global.char_to_show.reff.variables[$ (itemm.effect[ii][0])] -= itemm.effect[ii][1] * (1 + global.char_to_show.reff.variables.modifer[$ itemm.effect[ii][0]])}
                    }
        for (var j = 0; j < array_length(itemm.gives); j++){
                    if itemm.gives[j][0] == "skill"{
                        array_delete(global.char_to_show.reff.variables.skills, array_get_index(global.char_to_show.reff.variables.skills, itemm.gives[j][1]), 1)
                }}
    } else {
        // Надеваем предмет
        var ow = noone
        for (var i = 0; i <array_length(inventory_system.unequipped_items); i++){
            if inventory_system.selected_item == i{
                itemm = inventory_system.unequipped_items[i]
                array_delete(inventory_system.unequipped_items, i, 1);
                if itemm.type != "stat_up"{ow = itemm.owner
                itemm.owner = global.char_to_show
                array_push(inventory_system.equipped_items, itemm);
                array_push(global.equipped_items[global.inv_team - 1], itemm)}
                //show_message(global.equipped_items)
                for (var ii = 0; ii < array_length(itemm.effect); ii++){
                    if string_ends_with(itemm.effect[ii][0], "_perc"){
                        global.char_to_show.reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] /= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")])
                        global.char_to_show.reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] *= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] + itemm.effect[ii][1])
                        global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] += itemm.effect[ii][1]
                       }
                    else{
                        global.char_to_show.reff.variables[$ (itemm.effect[ii][0])] += itemm.effect[ii][1] * (1 + global.char_to_show.reff.variables.modifer[$ itemm.effect[ii][0]])}
                    }
                for (var j = 0; j < array_length(itemm.gives); j++){
                    if itemm.gives[j][0] == "skill"{
                        array_push(global.char_to_show.reff.variables.skills, object_get_safe_stats_shown(itemm.gives[j][1]))
                }
                    else if itemm.gives[j][0] == "buff"{
                        array_push(global.char_to_show.reff.variables.starter_statuses, itemm.gives[j][1])
                }
                }
                break
            }
        }
        if ow == noone{
            for (var i = 0; i <array_length(global.items_non_equipped[global.inv_team - 1]); i++){
            if itemm == global.items_non_equipped[global.inv_team - 1][i]{
                array_delete(global.items_non_equipped[global.inv_team - 1], i, 1);
                break
            }
        }
        }
        else{
        for (var i = 0; i <array_length(global.equipped_items[global.inv_team - 1]); i++){
            if itemm == global.equipped_items[global.inv_team - 1][i]{
                array_delete(global.equipped_items[global.inv_team - 1], i, 1);
                break
            }
        }
        for (var j = 0; j < array_length(global.not_sorted[global.inv_team-1]); j++){
            //show_message([ow.reff.variables.uid, global.not_sorted[global.inv_team-1][j].reff.variables.uid])
            if ow.reff.variables.uid == global.not_sorted[global.inv_team-1][j].reff.variables.uid{
                for (var t = 0; t < array_length(global.not_sorted[global.inv_team-1][j].reff.variables.equips); t++){
                    if global.not_sorted[global.inv_team-1][j].reff.variables.equips[t] == itemm{
                        array_delete(global.not_sorted[global.inv_team-1][j].reff.variables.equips, t, 1)
                        break
                    }
                }
            for (var ii = array_length(itemm.effect) - 1; ii >= 0; ii--){
                    if string_ends_with(itemm.effect[ii][0], "_perc"){
                        global.not_sorted[global.inv_team-1][j].reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] /= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")])
                        global.not_sorted[global.inv_team-1][j].reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] *= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] - itemm.effect[ii][1])
                        global.not_sorted[global.inv_team-1][j].reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] -= itemm.effect[ii][1]
                       }
                    else{
                        global.not_sorted[global.inv_team-1][j].reff.variables[$ (itemm.effect[ii][0])] -= itemm.effect[ii][1] * (1 + global.char_to_show.reff.variables.modifer[$ itemm.effect[ii][0]])}
                    }
            for (var jj= 0; jj < array_length(itemm.gives); jj++){
                    if itemm.gives[jj][0] == "skill"{
                        array_delete(global.not_sorted[global.inv_team-1][j].reff.variables.skills, array_get_index(global.char_to_show.reff.variables.skills, itemm.gives[jj][1]), 1)
                }}
            } 
        } 
        for (var j = 0; j < array_length(global.layout[global.inv_team-1]); j++){
            for (var f = 0; f < array_length(global.layout[global.inv_team-1][j]); f++){
                            //show_message([ow.reff.variables.uid, global.not_sorted[global.inv_team-1][j].reff.variables.uid])
            if ow.reff.variables.uid == global.layout[global.inv_team-1][j][f].reff.variables.uid{
                for (var t = 0; t < array_length(global.layout[global.inv_team-1][j][f].reff.variables.equips); t++){
                    if global.layout[global.inv_team-1][j][f].reff.variables.equips[t] == itemm{
                        array_delete(global.layout[global.inv_team-1][j][f].reff.variables.equips, t, 1)
                        break
                    }
                }
            for (var ii = array_length(itemm.effect) - 1; ii >= 0; ii--){
                    if string_ends_with(itemm.effect[ii][0], "_perc"){
                        global.layout[global.inv_team-1][j][f].reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] /= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")])
                        global.layout[global.inv_team-1][j][f].reff.variables[$ string_replace(itemm.effect[ii][0], "_perc", "")] *= (1 + global.char_to_show.reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] - itemm.effect[ii][1])
                        global.layout[global.inv_team-1][j][f].reff.variables.modifer[$ string_replace(itemm.effect[ii][0], "_perc", "")] -= itemm.effect[ii][1]
                       }
                    else{
                        global.layout[global.inv_team-1][j][f].reff.variables[$ (itemm.effect[ii][0])] -= itemm.effect[ii][1] * (1 + global.char_to_show.reff.variables.modifer[$ itemm.effect[ii][0]])}
                    }
            for (var jj= 0; jj < array_length(itemm.gives); jj++){
                    if itemm.gives[jj][0] == "skill"{
                        array_delete(global.layout[global.inv_team-1][j][f].reff.variables.skills, array_get_index(global.char_to_show.reff.variables.skills, itemm.gives[jj][1]), 1)
                }}
                } 
        }         
        }}
    }
    global.char_to_show.reff.variables.equips = inventory_system.equipped_items
    inventory_system.selected_item = -1;
   //show_message(inventory_system.equipped_items)
}
function draw_buttonn(x, y, w, h, text, callback) {
    var pressed = point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h);
    
    draw_set_color(pressed ? c_white : c_gray);
    draw_rectangle(x, y, x + w, y + h, false);
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_set_color(c_black)
    draw_text(x + w/2, y + h/2, text);
    
    if (pressed) and mouse_check_button_pressed(mb_left) {
        script_execute(callback);
    }
}

function draw_scrollbar(x, y, w, h, scroll, total_items, visible_items, list_index) {
    var ui = inventory_system.ui;
    //show_message([visible_items, total_items])
    // Фон скроллбара
    draw_set_color(c_gray);
    draw_rectangle(x, y, x + w, y + h, false);
    
    // Вычисляем параметры ползунка
    var slider_height = max(20, h * visible_items / total_items);
    var max_scroll = max(1, total_items - visible_items);
    var slider_y = y + scroll * (h - slider_height) / max_scroll;
    
    // Проверяем hover
    var mouse_over = point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h);
    var slider_hover = point_in_rectangle(mouse_x, mouse_y, x, slider_y, x + w, slider_y + slider_height);
    
    // Цвет ползунка
    var color = (ui.drag.active && ui.drag.list == list_index) || slider_hover ? c_white : c_ltgray;
    draw_set_color(color);
    draw_rectangle(x, slider_y, x + w, slider_y + slider_height, true);
    
    // Стрелки
    draw_set_color(mouse_over && mouse_y < y + 20 ? c_white : c_ltgray);
    draw_triangle(x + w/2, y + 5, x + 3, y + 15, x + w - 3, y + 15, true);
    
    draw_set_color(mouse_over && mouse_y > y + h - 20 ? c_white : c_ltgray);
    draw_triangle(x + w/2, y + h - 5, x + 3, y + h - 15, x + w - 3, y + h - 15, true);
}

function inventory_handle_input() {
    var ui = inventory_system.ui;
    
    // Обработка отпускания мыши
    if (mouse_check_button_released(mb_left)) {
        ui.drag.active = false;
        ui.button_pressed = false;
        
        // Если кнопка была нажата и отпущена над ней - перемещаем предмет
        if (ui.button_pressed && point_in_rectangle(mouse_x, mouse_y, 
            ui.x + ui.width + 10, ui.y + ui.height - 30, 
            ui.x + ui.width + 90, ui.y + ui.height - 5)) {
            inventory_move_item();
        }
    }
    
    // Обработка скролла колесиком
    if (mouse_wheel_down()) ui_scroll(3);
    if (mouse_wheel_up()) ui_scroll(-3);
    
    // Обработка стрелок клавиатуры
    if (keyboard_check_pressed(vk_up)) ui_scroll(-1);
    if (keyboard_check_pressed(vk_down)) ui_scroll(1);
    
    // Обработка кликов по предметам
    if (mouse_check_button_pressed(mb_left)) {
        // Проверяем клик в левом списке (экипированные)
        if (point_in_rectangle(mouse_x, mouse_y, 
            ui.x + 10, ui.y + 40, 
            ui.x + ui.width - 25, ui.y + ui.height - 40)) {
            
            var rel_y = mouse_y - (ui.y + 40);
            var item_index = floor(rel_y / ui.item_height) + ui.scroll[0];
            
            if (item_index < array_length(inventory_system.equipped_items)) {
                inventory_system.selected_item = item_index;
                inventory_system.selected_list = 0;
            }
        }
        
        // Проверяем клик в правом списке (неэкипированные)
        if (point_in_rectangle(mouse_x, mouse_y, 
            ui.x + ui.width + 20, ui.y + 40, 
            ui.x + 2*ui.width - 5, ui.y + ui.height - 40)) {
            
            var rel_y = mouse_y - (ui.y + 40);
            var item_index = floor(rel_y / ui.item_height) + ui.scroll[1];
            
            if (item_index < array_length(inventory_system.unequipped_items)) {
                inventory_system.selected_item = item_index;
                inventory_system.selected_list = 1;
            }
        }
        
        // Проверяем клик по кнопке "Переместить"
        if (inventory_system.selected_item != -1 && 
            point_in_rectangle(mouse_x, mouse_y, 
            ui.x + ui.width + 10, ui.y + ui.height - 30, 
            ui.x + ui.width + 90, ui.y + ui.height - 5)) {
            
            ui.button_pressed = true;
        }
    }
    
    if (mouse_check_button_pressed(mb_left)) {
    // Проверяем оба скроллбара
    for (var i = 0; i < 2; i++) {
        var sx = ui.x + ui.width - 30 + (i == 1 ? ui.width + 20 : 0);
        
        // Хитбокс всего скроллбара (включая стрелки)
        if (point_in_rectangle(mouse_x, mouse_y, sx, ui.y + 40, sx + 15, ui.y + ui.height - 40)) {
            // Клик по стрелке вверх
            if (mouse_y < ui.y + 60) {
                ui.scroll[i] = max(0, ui.scroll[i] - 1);
            }
            // Клик по стрелке вниз
            else if (mouse_y > ui.y + ui.height - 60) {
                var items = i == 0 ? inventory_system.equipped_items : inventory_system.unequipped_items;
                var visiblee = floor(ui.height / ui.item_height);
                // Исправлено: теперь можно дойти до последнего элемента
                ui.scroll[i] = min(array_length(items) - 1, ui.scroll[i] + 1);
            }
            // Клик по ползунку или области скроллбара
            else {
                ui.drag.active = true;
                ui.drag.list = i;
                ui.drag.start_y = mouse_y;
                ui.drag.start_scroll = ui.scroll[i];
            }
            break;
        }
    }
}

// Продолжаем drag, если начали
if (ui.drag.active && mouse_check_button(mb_left)) {
    var items = ui.drag.list == 0 ? inventory_system.equipped_items : inventory_system.unequipped_items;
    var visiblee = floor(ui.height / ui.item_height);
    var delta = mouse_y - ui.drag.start_y;
    // Исправлено: теперь можно дойти до последнего элемента
    ui.scroll[ui.drag.list] = clamp(
        ui.drag.start_scroll + delta * array_length(items) / ui.height,
        0,
        max(0, array_length(items) - 1)
    );
}
}
// Вспомогательная функция для скролла
function ui_scroll(amount) {
    var ui = inventory_system.ui;
    var mx = mouse_x - ui.x;
    var my = mouse_y - ui.y;
    
    // Определяем над каким списком курсор
    if (mx > 0 && mx < ui.width && my > 0 && my < ui.height) {
        ui.scroll[0] = clamp(ui.scroll[0] + amount, 0, max(0, array_length(inventory_system.equipped_items) - floor(ui.height/ui.item_height)));
    }
    else if (mx > ui.width + 20 && mx < 2*ui.width + 20 && my > 0 && my < ui.height) {
        ui.scroll[1] = clamp(ui.scroll[1] + amount, 0, max(0, array_length(inventory_system.unequipped_items) - floor(ui.height/ui.item_height)));
    }
}

// 5. ОСНОВНАЯ ФУНКЦИЯ ОТРИСОВКИ
function inventory_draw() {
    var ui = inventory_system.ui;
    
    // Отрисовка списков
    draw_items_list(ui.x + 10, ui.y + 40, ui.width - 20, ui.height - 80, 
                  inventory_system.equipped_items, 0);
    
    draw_items_list(ui.x + ui.width + 20, ui.y + 40, ui.width - 20, ui.height - 80, 
                  inventory_system.unequipped_items, 1);
    
    // Заголовки
    draw_set_color(c_white);
    draw_text(ui.x + 10, ui.y + 10, "Инвентарь:");
    draw_text(ui.x + ui.width + 20, ui.y + 10, "Другие предметы:");
    
    // Кнопка перемещения (только если есть выбранный предмет)
        var btn_x = ui.x + ui.width - 60;
        var btn_y = ui.y + ui.height - 30;
        var btn_w = 120;
        var btn_h = 45;
        draw_buttonn(btn_x, btn_y, btn_w, btn_h, "Переместить", inventory_move_item)
}


function object_get_safe_stats_shown(obj) {
    if typeof(obj) == "struct"{
        return obj
    }
    // Проверяем тип входных данных
    if (instance_exists(obj)) {
        // Работаем с экземпляром
        return get_instance_stats_shown(obj);
    }
    else if (object_exists(obj)) {
        // Работаем с шаблоном объекта
        return get_object_template_stats_shown(obj);
    }
    else {
        show_debug_message("Invalid object reference:", obj);
        return undefined;
    }
}

function get_instance_stats_shown(inst) {
    var stats_shown = {
        object_index: inst.object_index,
        variables: {}
    };
    
    // Получаем только изменяемые переменные
    var vars = variable_instance_get_names(inst);
    for (var i = 0; i < array_length(vars); i++) {
        var var_name = vars[i];
        
        // Пропускаем системные и служебные переменные
        if (!string_starts_with(var_name, "__") && var_name != "object_index") {
            try {
                stats_shown.variables[$ var_name] = inst[$ var_name];
            } catch(e) {
                show_debug_message("Failed to copy variable", var_name, ":", e);
            }
        }
    }
    var meths = (inst);
    for (var i = 0; i < array_length(meths); i++) {
        var var_name = meths[i];
        
        // Пропускаем системные и служебные переменные
        if (!string_starts_with(var_name, "__") && var_name != "object_index") {
            try {
                stats_shown.variables[$ var_name] = inst[$ var_name];
            } catch(e) {
                show_debug_message("Failed to copy variable", var_name, ":", e);
            }
        }
    }
    return stats_shown;
}

function get_object_template_stats_shown(obj_index) {
    // Создаем временный экземпляр для получения данных по умолчанию
    var temp_inst = instance_create_depth(0, 0, -10000, obj_index, {temp:true});
    var stats_shown = get_instance_stats_shown(temp_inst);
    instance_destroy(temp_inst);
    
    return stats_shown;
}