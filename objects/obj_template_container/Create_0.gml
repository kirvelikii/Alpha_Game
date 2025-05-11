// Получаем параметры
var template = template_data;
var layerr = target_layer;
var team = target_team;

// 1. Создаем реальный объект
spawned_instance = instance_create_layer(x, y, layerr, template.reff.object_index, { team: team });

// 2. Применяем все переменные
if (instance_exists(spawned_instance)) {
    var vars = template.reff.variables;
    var var_names = variable_struct_get_names(vars);
    
    for (var i = 0; i < array_length(var_names); i++) {
        var name = var_names[i];
        spawned_instance[$ name] = vars[$ name];
    }
    
    // 3. Привязываем методы
    if (variable_struct_exists(template.reff, "methods")) {
        var methods = template.reff.methods;
        var method_names = variable_struct_get_names(methods);
        
        for (var i = 0; i < array_length(method_names); i++) {
            var m_name = method_names[i];
            spawned_instance[$ m_name] = method(spawned_instance, methods[$ m_name]);
        }
    }
}

// 4. Уничтожаем контейнер
instance_destroy();