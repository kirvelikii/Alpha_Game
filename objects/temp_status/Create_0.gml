name = "fragility"
description = "Увеличивает получаемый целью урон, на процент, равный силе эффекта"
type = fragility
constance = false
proof = "debuff"
is_stackable = true
effec = sp_fragility
effec_alpha = 0.5
if room == fight{
params = struct_merge(stackable_params, unstackable_params, true)
    stacks = [{}] 
    var names = struct_get_names(params)
for (var i = 0; i < array_length(names); i++){
        stacks[0][$ names[i]] = params[$ names[i]]
    }    
//duration = params.duration
//potency = params.potency
image_xscale = host.image_xscale
array_push(host.statuses_visual, self)
number = array_get_index(host.statuses_visual, self)
x = host.x + (image_xscale * 32 * number) % 128
y = host.y + 96 - floor(32 * number / 128) * 32
function add_params(par, upar) {
    // Проверяем, что par - это структура
    if (!is_struct(par)) return;
    object = self    
    
    // Получаем все имена параметров из структуры par
    var params = variable_struct_get_names(par);
    
    for (var i = 0; i < array_length(params); i++) {
        var param_name = params[i];
        var param_value = par[$ param_name];
        
        if (variable_instance_exists(object, param_name)) {
            object[$ param_name] += param_value;
        } else {
            object[$ param_name] = param_value;
        }
} 
    array_push(stacks, struct_merge(par, upar))    
}


function struct_merge(struct1, struct2, overwrite) {
    // Если overwrite не указан, по умолчанию true
    if (is_undefined(overwrite)) overwrite = true;
    
    // Создаём копию первого структуры
    var result = variable_struct_get_names(struct1);
    var temp = {};
    for (var i = 0; i < array_length(result); i++) {
        var key = result[i];
        temp[$ key] = struct1[$ key];
    }
    
    // Добавляем значения из второго структуры
    var keys = variable_struct_get_names(struct2);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        // Если ключ уже существует и overwrite false, пропускаем
        if (!overwrite && variable_struct_exists(temp, key)) continue;
        temp[$ key] = struct2[$ key];
    }
    
    return temp;
}
//cad_formula = min(4, potency/5)
}