global.player_exp = 10000
focus_tree = global.char_to_show.reff.variables.focus_tree
focus_object_map = ds_map_create();
function get_focus_object(focus_id) {
    if (ds_map_exists(focus_object_map, focus_id)) {
        return ds_map_find_value(focus_object_map, focus_id);
    }
    return noone;
}

function create_focus_objects() {
    ds_map_clear(focus_object_map);
    
    for (var i = 0; i < array_length(focus_tree); i++) {
        var data = focus_tree[i];
        var inst = instance_create_layer(0, 0, "Instances", obj_focus_block,
        
        // Передаём ТОЛЬКО нужные данные
    {
        focus_id: data.focus_id,
        focus_name: data.focus_name,
        focus_description: data.focus_description,
        focus_cost: data.focus_cost,
        focus_prerequisites: data.focus_prerequisites,
        focus_unlocked: data.focus_unlocked,
        focus_icon: data.focus_icon,
        focus_restrictions: data.focus_restrictions,
        stat_changes: data.stat_changes,
        gives: data.gives}
        );
        // Сохраняем ссылку
        ds_map_add(focus_object_map, data.focus_id, inst);
    }
    
    arrange_by_dependencies();
}
function get_focus_instance(focus_id) {
    return ds_map_exists(focus_object_map, focus_id) 
        ? ds_map_find_value(focus_object_map, focus_id) 
        : noone;
}
// Функция для получения данных фокуса
function get_focus_data(focus_id) {
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (focus_tree[i].focus_id == focus_id) {
            return focus_tree[i];
        }
    }
    return undefined;
}

// Функция обновления статуса фокуса
function update_focus_status(focus_id, unlocked) {
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (focus_tree[i].focus_id == focus_id) {
            focus_tree[i].focus_unlocked = unlocked;
            return true;
        }
    }
    return false;
}

function calculate_dependency_depth(focus_id, visited = []) {
    // Защита от циклов
    if (array_contains(visited, focus_id)) {
        show_debug_message("Обнаружен цикл в зависимостях: " + focus_id);
        return 0;
    }
    
    var focus = get_focus_data(focus_id);
    if (focus == undefined) {
        show_debug_message("Фокус не найден: " + focus_id);
        return 0;
    }
    
    // Если глубина уже вычислена и не -1, возвращаем ее
    if (focus.dep >= 0) {
        return focus.dep;
    }
    
    array_push(visited, focus_id);
    var max_depth = -1;
    
    // Вычисляем максимальную глубину среди требований
    for (var i = 0; i < array_length(focus.focus_prerequisites); i++) {
        var parent_depth = calculate_dependency_depth(focus.focus_prerequisites[i], visited);
        max_depth = max(max_depth, parent_depth);
    }
    
    focus.dep = max_depth + 1;
    return focus.dep;
}
function arrange_by_dependencies() {
    // 1. Сбрасываем и рассчитываем глубину
    for (var i = 0; i < array_length(focus_tree); i++) {
        focus_tree[i].dep = -1;
    }
    
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (focus_tree[i].dep < 0) {
            focus_tree[i].dep = calculate_dependency_depth(focus_tree[i].focus_id);
        }
    }
    
    // 2. Группируем узлы по глубине
    var depth_map = ds_map_create();
    for (var i = 0; i < array_length(focus_tree); i++) {
        var dep = focus_tree[i].dep;
        if (!ds_map_exists(depth_map, dep)) {
            depth_map[? dep] = [];
        }
        array_push(depth_map[? dep], focus_tree[i]);
    }
    
    // 3. Расставляем позиции
    var base_x = 100; // Стартовая позиция по X
    var base_y = room_height / 2; // Центр по вертикали
    var x_step = 250; // Шаг между уровнями
    var y_step = 196; // Шаг между узлами
    
    var depths = ds_map_keys_to_array(depth_map);
    array_sort(depths, true); // Сортируем глубины
    
    for (var i = 0; i < array_length(depths); i++) {
        var focuses = depth_map[? depths[i]];
        var start_y = base_y - (array_length(focuses) * y_step) / 2;
        
        for (var j = 0; j < array_length(focuses); j++) {
            // Обновляем позицию в данных
            focuses[j].position = {
                x: base_x + depths[i] * x_step,
                y: start_y + j * y_step
            };
            
            // Обновляем позицию объекта
            var inst = get_focus_object(focuses[j].focus_id);
            if (inst != noone) {
                inst.x = focuses[j].position.x;
                inst.y = focuses[j].position.y;
            }
        }
    }
    
    ds_map_destroy(depth_map);
    
    // 4. Центрируем дерево
    center_tree();
}

function center_tree() {
    // Находим границы дерева
    var min_x = room_width, max_x = 0, min_y = room_height, max_y = 0;
    
    for (var i = 0; i < array_length(focus_tree); i++) {
        var pos = focus_tree[i].position;
        min_x = min(min_x, pos.x);
        max_x = max(max_x, pos.x);
        min_y = min(min_y, pos.y);
        max_y = max(max_y, pos.y);
    }
    
    // Вычисляем смещение для центрирования
    var offset_x = (room_width - (max_x - min_x)) / 2 - min_x;
    var offset_y = (room_height - (max_y - min_y)) / 2 - min_y;
    
    // Применяем смещение ко всем объектам
    for (var i = 0; i < array_length(focus_tree); i++) {
        focus_tree[i].position.x += offset_x;
        focus_tree[i].position.y += offset_y;
        
        var inst = get_focus_object(focus_tree[i].focus_id);
        if (inst != noone) {
            inst.x = focus_tree[i].position.x;
            inst.y = focus_tree[i].position.y;
        }
    }
}


function find_focus_data_by_id(focus_id) {
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (focus_tree[i].focus_id == focus_id) return focus_tree[i];
    }
    return undefined;
}

function add_new_focus(focus_data) {
    array_push(focus_tree, focus_data);
    var new_obj = instance_create_layer(0, 0, "Instances", obj_focus_block, focus_data);
    arrange_by_dependencies();
    return new_obj;
}

function arrange_hoi4_style() {
    // Сбрасываем позиции
    for (var i = 0; i < array_length(focus_tree); i++) {
        focus_tree[i].position = {x: 0, y: 0};
        focus_tree[i].calculated = false;
    }
    
    // Параметры расстановки
    var start_x = room_width / 2;
    var start_y = 100;
    var x_spacing = 120;
    var y_spacing = 120;
    
    // Находим корневые узлы (без требований)
    var roots = [];
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (array_length(focus_tree[i].focus_prerequisites) == 0) {
            array_push(roots, focus_tree[i]);
        }
    }
    
    // Расставляем корневые узлы
    for (var i = 0; i < array_length(roots); i++) {
        roots[i].position.x = start_x + (i - array_length(roots)/2) * x_spacing;
        roots[i].position.y = start_y;
        roots[i].calculated = true;
    }
    
    // Рекурсивно расставляем остальные
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (!focus_tree[i].calculated) {
            position_focus(focus_tree[i], x_spacing, y_spacing);
        }
    }
    
    // Обновляем позиции объектов
    apply_positions();
}

// Рекурсивная расстановка
function position_focus(focus, x_spacing, y_spacing) {
    if (focus.calculated) return;
    
    // Находим позицию первого родителя
    var parent = get_focus_data(focus.focus_prerequisites[0]);
    if (parent == undefined) return;
    
    // Если родитель еще не расставлен - расставляем его сначала
    if (!parent.calculated) {
        position_focus(parent, x_spacing, y_spacing);
    }
    
    // Позиция под родителем
    focus.position.x = parent.position.x;
    focus.position.y = parent.position.y + y_spacing;
    
    // Корректируем позицию, если есть "братья"
    var siblings = get_focuses_with_parent(focus.focus_prerequisites[0]);
    if (array_length(siblings) > 1) {
        // Заменяем array_pos на ручной поиск индекса
        var index = -1;
        for (var i = 0; i < array_length(siblings); i++) {
            if (siblings[i].focus_id == focus.focus_id) {
                index = i;
                break;
            }
        }
        
        if (index != -1) {
            focus.position.x = parent.position.x + (index - (array_length(siblings)-1)/2) * x_spacing;
        }
    }
    
    focus.calculated = true;
}

// Вспомогательные функции
function get_focuses_with_parent(parent_id) {
    var result = [];
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (array_contains(focus_tree[i].focus_prerequisites, parent_id)) {
            array_push(result, focus_tree[i]);
        }
    }
    return result;
}

function apply_positions() {
    for (var i = 0; i < array_length(focus_tree); i++) {
        var inst = get_focus_object(focus_tree[i].focus_id);
        if (inst != noone) {
            inst.x = focus_tree[i].position.x;
            inst.y = focus_tree[i].position.y;
        }
    }
}
function draw_hoi4_connections() {
    draw_set_color(c_white);
    draw_set_alpha(0.7);
    
    for (var i = 0; i < array_length(focus_tree); i++) {
        var focus = focus_tree[i];
        var inst = get_focus_object(focus.focus_id);
        
        if (inst != noone) {
            for (var j = 0; j < array_length(focus.focus_prerequisites); j++) {
                var parent = get_focus_object(focus.focus_prerequisites[j]);
                if (parent != noone) {
                    // Горизонтальная линия к центру
                    var mid_y = parent.y + (inst.y - parent.y) * 0.3 + 32 + 48;
                    draw_line_width(parent.x + 32, parent.y + 64 + 48, parent.x + 32, mid_y, 3);
                    draw_line_width(parent.x + 32, mid_y, inst.x + 32, mid_y, 3);
                    draw_line_width(inst.x + 32, mid_y, inst.x + 32, inst.y, 3);
                }
            }
        }
    }
    
    draw_set_alpha(1);
}

// Новая структура для хранения информации о деревьях
tree_data = [];
// Основная функция расстановки
function arrange_trees() {
    // 1. Разделяем фокусы на отдельные деревья
    var root_foci = [];
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (array_length(focus_tree[i].focus_prerequisites) == 0) {
            array_push(root_foci, focus_tree[i]);
        }
    }
    
    // 2. Для каждого корня вычисляем ширину дерева
    var treess = [];
    for (var i = 0; i < array_length(root_foci); i++) {
        var tree = {
            root: root_foci[i],
            width: calculate_tree_width(root_foci[i])
        };
        array_push(treess, tree);
    }
    
    // 3. Распределяем деревья по горизонтали
    var total_width = 0;
    for (var i = 0; i < array_length(treess); i++) {
        total_width += treess[i].width;
    }
    
    var spacing = 200; // Минимальное расстояние между деревьями
    var start_x = (room_width - total_width - (array_length(treess)-1)*spacing) / 2;
    var current_x = start_x;
    
    // 4. Позиционируем каждое дерево
    for (var i = 0; i < array_length(treess); i++) {
        position_tree(treess[i].root, current_x + treess[i].width/2, 100);
        current_x += treess[i].width + spacing;
    }
    
    // 5. Обновляем позиции объектов
    apply_positions();
}

// Вспомогательные функции
function get_all_tree_nodes(root_focus) {
    var nodes = [root_focus];
    var i = 0;
    
    while (i < array_length(nodes)) {
        var current = nodes[i];
        var children = get_children(current.focus_id);
        
        for (var j = 0; j < array_length(children); j++) {
            if (!array_contains(nodes, children[j])) {
                array_push(nodes, children[j]);
            }
        }
        i++;
    }
    
    return nodes;
}

function get_relative_x_position(focus) {
    if (array_length(focus.focus_prerequisites) == 0) return 0;
    
    var parent = get_focus_data(focus.focus_prerequisites[0]);
    if (parent == undefined) return 0;
    
    var siblings = get_children(parent.focus_id);
    var index = find_focus_index(siblings, focus);
    
    if (index == -1) return 0;
    
    // Центрируем позиции относительно родителя
    return (index - (array_length(siblings)-1)/2) * 120;
}
function calculate_all_depths() {
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (focus_tree[i].dep == undefined) {
            focus_tree[i].dep = calculate_depth(focus_tree[i].focus_id);
        }
    }
}

function calculate_depth(focus_id, visited = []) {
    if (array_contains(visited, focus_id)) return 0;
    
    var focus = get_focus_data(focus_id);
    if (focus == undefined) return 0;
    
    array_push(visited, focus_id);
    var max_depth = 0;
    
    // Для каждого родителя вычисляем глубину
    for (var i = 0; i < array_length(focus.focus_prerequisites); i++) {
        var parent_depth = calculate_depth(focus.focus_prerequisites[i], visited);
        max_depth = max(max_depth, parent_depth);
    }
    
    focus.dep = max_depth + 1;
    return focus.dep;
}
function array_find_index(_array, _value) {
    for (var i = 0; i < array_length(_array); i++) {
        if (_array[i] == _value) return i;
    }
    return -1;
}

function find_focus_index(siblings, focus) {
    for (var i = 0; i < array_length(siblings); i++) {
        if (siblings[i].focus_id == focus.focus_id) {
            return i;
        }
    }
    return -1;
}

function arrange_focus_tree() {
    // 1. Находим все корневые узлы
    var root_nodes = [];
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (array_length(focus_tree[i].focus_prerequisites) == 0) {
            array_push(root_nodes, focus_tree[i]);
        }
    }
    
    // 2. Создаем структуры для каждого дерева
    var tree_structures = [];
    for (var i = 0; i < array_length(root_nodes); i++) {
        var nodes_in_tree = get_all_nodes_in_tree(root_nodes[i]);
        var tree_width = calculate_tree_width(nodes_in_tree);
        
        array_push(tree_structures, {
            main_root: root_nodes[i],
            all_nodes: nodes_in_tree,
            tree_width: tree_width
        });
    }
    
    // 3. Вычисляем общую ширину всех деревьев
    var combined_width = 0;
    for (var i = 0; i < array_length(tree_structures); i++) {
        combined_width += tree_structures[i].tree_width;
    }
    
    // 4. Распределяем деревья по экрану
    var tree_spacing = 200;
    var current_x = (1100 + combined_width + (array_length(tree_structures)-1)*tree_spacing) / 2;
    
    for (var i = 0; i < array_length(tree_structures); i++) {
        position_single_tree(
            tree_structures[i].all_nodes,
            current_x + tree_structures[i].tree_width/2,
            300,
            tree_structures[i].tree_width
        );
        current_x += tree_structures[i].tree_width + tree_spacing;
    }
    
    // 5. Применяем позиции к объектам
    update_all_positions();
}

function get_tree_nodes(root) {
    var nodes = [root];
    var i = 0;
    
    while (i < array_length(nodes)) {
        var children = get_children(nodes[i].focus_id);
        for (var j = 0; j < array_length(children); j++) {
            if (!array_contains(nodes, children[j])) {
                array_push(nodes, children[j]);
            }
        }
        i++;
    }
    
    return nodes;
}

function position_tree(nodes, center_x, start_y, tree_width) {
    var x_spacing = 150;
    var y_spacing = 120;
    
    // Группируем по глубине
    var depth_map = ds_map_create();
    for (var i = 0; i < array_length(nodes); i++) {
        var dep = nodes[i].dep;
        if (!ds_map_exists(depth_map, dep)) {
            depth_map[? dep] = [];
        }
        array_push(depth_map[? dep], nodes[i]);
    }
    
    var depths = ds_map_keys_to_array(depth_map);
    array_sort(depths, true);
    
    for (var i = 0; i < array_length(depths); i++) {
        var focuses = depth_map[? depths[i]];
        var level_start = center_x - (array_length(focuses) - 1) * x_spacing / 2;
        
        for (var j = 0; j < array_length(focuses); j++) {
            // Для узлов с несколькими родителями - средняя позиция
            if (array_length(focuses[j].focus_prerequisites) > 1) {
                var avg_x = 0;
                var parents = 0;
                for (var k = 0; k < array_length(focuses[j].focus_prerequisites); k++) {
                    var parent = get_focus_data(focuses[j].focus_prerequisites[k]);
                    if (parent != undefined) {
                        avg_x += parent.position.x;
                        parents++;
                    }
                }
                if (parents > 0) {
                    focuses[j].position.x = avg_x / parents;
                } else {
                    focuses[j].position.x = level_start + j * x_spacing;
                }
            } else {
                focuses[j].position.x = level_start + j * x_spacing;
            }
            
            focuses[j].position.y = start_y + (depths[i] - 1) * y_spacing;
        }
    }
    
    ds_map_destroy(depth_map);
}
function get_children(parent_id) {
    var children = [];
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (array_contains(focus_tree[i].focus_prerequisites, parent_id)) {
            array_push(children, focus_tree[i]);
        }
    }
    return children;
}
function array_contains(arr, value) {
    for (var i = 0; i < array_length(arr); i++) {
        if (arr[i] == value) return true;
    }
    return false;
}
function array_reduce(arr, initial, func) {
    var result = initial;
    for (var i = 0; i < array_length(arr); i++) {
        result = func(result, arr[i]);
    }
    return result;
}
function get_all_nodes_in_tree(root_node) {
    var tree_nodes = [root_node];
    var i = 0;
    
    while (i < array_length(tree_nodes)) {
        var child_nodes = get_direct_children(tree_nodes[i].focus_id);
        for (var j = 0; j < array_length(child_nodes); j++) {
            if (!is_node_in_list(tree_nodes, child_nodes[j].focus_id)) {
                array_push(tree_nodes, child_nodes[j]);
            }
        }
        i++;
    }
    
    return tree_nodes;
}

function get_direct_children(parent_id) {
    var children = [];
    for (var i = 0; i < array_length(focus_tree); i++) {
        if (array_contains(focus_tree[i].focus_prerequisites, parent_id)) {
            array_push(children, focus_tree[i]);
        }
    }
    return children;
}

function is_node_in_list(node_list, node_id) {
    for (var i = 0; i < array_length(node_list); i++) {
        if (node_list[i].focus_id == node_id) return true;
    }
    return false;
}

function calculate_tree_width(tree_nodes) {
    // Группируем узлы по уровням глубины
    var level_map = ds_map_create();
    for (var i = 0; i < array_length(tree_nodes); i++) {
        var depth_level = tree_nodes[i].dep;
        if (!ds_map_exists(level_map, depth_level)) {
            level_map[? depth_level] = [];
        }
        array_push(level_map[? depth_level], tree_nodes[i]);
    }
    
    // Находим самый широкий уровень
    var max_level_width = 0;
    var node_spacing = 150;
    var depth_levels = ds_map_keys_to_array(level_map);
    
    for (var i = 0; i < array_length(depth_levels); i++) {
        var nodes_on_level = level_map[? depth_levels[i]];
        var level_width = (array_length(nodes_on_level) - 1) * node_spacing;
        max_level_width = max(max_level_width, level_width);
    }
    
    ds_map_destroy(level_map);
    return max(max_level_width, node_spacing); // Минимальная ширина
}

function position_single_tree(tree_nodes, center_x, start_y, total_width) {
    var x_spacing = 150 + 32; // Расстояние между узлами по X
    var y_spacing = 120 + 64; // Расстояние между уровнями по Y
    var min_node_distance = x_spacing * 0.9; // Минимальное расстояние между узлами
    
    // Группируем узлы по глубине
    var depth_groups = ds_map_create();
    for (var i = 0; i < array_length(tree_nodes); i++) {
        var depthh = tree_nodes[i].dep;
        if (!ds_map_exists(depth_groups, depthh)) {
            depth_groups[? depthh] = [];
        }
        array_push(depth_groups[? depthh], tree_nodes[i]);
    }
    
    // Сортируем уровни по глубине
    var depths = ds_map_keys_to_array(depth_groups);
    array_sort(depths, true);
    
    // 1. Сначала расставляем все узлы равномерно
    for (var i = 0; i < array_length(depths); i++) {
        var level_nodes = depth_groups[? depths[i]];
        var level_width = (array_length(level_nodes) - 1) * x_spacing;
        var level_start_x = center_x - level_width / 2;
        
        for (var j = 0; j < array_length(level_nodes); j++) {
            level_nodes[j].position = {
                x: level_start_x + j * x_spacing,
                y: start_y + (depths[i] - 1) * y_spacing
            };
        }
    }
    
    // 2. Корректируем позиции для узлов с несколькими родителями
    for (var i = 1; i < array_length(depths); i++) { // Начинаем с 1, так как корни уже расставлены
        var level_nodes = depth_groups[? depths[i]];
        
        // Сортируем узлы по количеству родителей (сначала многородительские)
        array_sort(level_nodes, function(a, b) {
            return array_length(b.focus_prerequisites) - array_length(a.focus_prerequisites);
        });
        
        for (var j = 0; j < array_length(level_nodes); j++) {
            var node = level_nodes[j];
            var parents = [];
            
            // Находим всех родителей
            for (var k = 0; k < array_length(node.focus_prerequisites); k++) {
                var parent = get_focus_data(node.focus_prerequisites[k]);
                if (parent != undefined) array_push(parents, parent);
            }
            
            if (array_length(parents) > 1) {
                // Вычисляем идеальную позицию - среднюю между родителями
                var sum_x = 0;
                for (var k = 0; k < array_length(parents); k++) {
                    sum_x += parents[k].position.x;
                }
                var target_x = sum_x / array_length(parents);
                
                // Ищем ближайшую свободную позицию к target_x
                var best_x = node.position.x; // Начальное значение - текущая позиция
                var best_offset = 0;
                var found = false;
                
                // Проверяем позиции в порядке возрастания расстояния от target_x
                for (var offset = 0; offset <= array_length(level_nodes) * x_spacing; offset += x_spacing / 2) {
                    // Проверяем в обе стороны от target_x
                    for (var dir = -1; dir <= 1; dir += 2) {
                        if (dir == 0) continue;
                        var test_x = target_x + dir * offset;
                        
                        // Проверяем, что позиция свободна
                        var collision = false;
                        for (var k = 0; k < array_length(level_nodes); k++) {
                            if (level_nodes[k] != node && abs(level_nodes[k].position.x - test_x) < min_node_distance) {
                                collision = true;
                                break;
                            }
                        }
                        
                        if (!collision) {
                            best_x = test_x;
                            found = true;
                            break;
                        }
                    }
                    if (found) break;
                }
                
                // Обновляем позицию узла
                node.position.x = best_x;
                
                // Сдвигаем соседние узлы, если нужно
                if (found) {
                    var shift_direction = (best_x > target_x) ? 1 : -1;
                    var shift_amount = x_spacing * 0.2;
                    
                    for (var k = 0; k < array_length(level_nodes); k++) {
                        if (level_nodes[k] != node && abs(level_nodes[k].position.x - best_x) < x_spacing) {
                            level_nodes[k].position.x += shift_direction * shift_amount;
                        }
                    }
                }
            }
        }
    }
    
    // 3. Центрируем каждый уровень относительно его узлов
    for (var i = 0; i < array_length(depths); i++) {
        var level_nodes = depth_groups[? depths[i]];
        if (array_length(level_nodes) == 0) continue;
        
        // Находим min и max X позиции на уровне
        var min_x = level_nodes[0].position.x;
        var max_x = level_nodes[0].position.x;
        
        for (var j = 1; j < array_length(level_nodes); j++) {
            min_x = min(min_x, level_nodes[j].position.x);
            max_x = max(max_x, level_nodes[j].position.x);
        }
        
        // Вычисляем смещение для центрирования
        var level_center = (min_x + max_x) / 2;
        var offset = center_x - level_center;
        
        // Применяем смещение ко всем узлам уровня
        for (var j = 0; j < array_length(level_nodes); j++) {
            level_nodes[j].position.x += offset;
        }
    }
    
    ds_map_destroy(depth_groups);
}

function update_all_positions() {
    for (var i = 0; i < array_length(focus_tree); i++) {
        var focus_obj = get_focus_object(focus_tree[i].focus_id);
        if (focus_obj != noone) {
            focus_obj.x = focus_tree[i].position.x;
            focus_obj.y = focus_tree[i].position.y;
        }
    }
}
// Инициализация при старте
create_focus_objects();
arrange_focus_tree();