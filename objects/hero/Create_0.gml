if room != fight{
    if room == pre_fight{
        team = inv_ruleset.team
    }
    else{
        team = global.char_to_show.reff.variables.team
    }
}
if temp{
    uid = id
    expp = 10000
    type = hero
    max_hp = 100
    basic_attack = 5
    attack_interval = 60 * 1.5
    attack_delay = 10
    basic_range = 1
    basic_accuracy = 85
    dodge_chance = 5
    mov_speed = 1 / 2
    basic_target_count = 1
    basic_crit_chance = 50
    basic_crit_damage = 2
    name = "Template"
    lore = "Начало начал, этот человек видел многое, он основал множество техник, опробовал все, что есть в этом мире. Не пора ли ему уйти на пенсию?"
    skills = [template_skill]
    for (var i = 0; i < array_length(skills); i++){
        skills[i] = object_get_safe_stats_shown(skills[i])
        //instance_create_layer(x - 64 * (i+1), y, "Instances", skills[i], {host: id})
        //instance_create_layer(x +  64 * (i+1), y, "Instances", skills[i], {host: id, image_xscale: -1})
    }
    legacy_skills = [template_skill]
    equips = []
    starter_statuses = []
    common_pos = "frontline"
    crit_eff = basic_crit_attack_effect
    eff = basic_attack_effect
    hp = max_hp 
    max_sanity = 100
    low_sanity_effect = {s50: "retreat", s25: "panic", s0: "crazy"}
    damage_to_sanity = {damage: {hp75: 0.45, hp50:0.65, hp25:1.5, hp10: 3}, ally_death:{row: 15, glob: 8}}
    heal_sanity = {kill: 20, enemy_death:{row: 5, glob: 0}, succesful_retreat: 20, sanity_on_panic: 0.4}
    state = "normal"
    modifer = { 
    max_hp: 0,
    basic_attack: 0,
    basic_range: 0,
    attack_interval: 0,
    basic_accuracy: 0,
    basic_crit_chance: 0,
    basic_crit_damage: 0,
    dodge_chance: 0,
    mov_speed: 0,
    max_sanity: 0,
    }
    statistics = {
        damage : {total: 0, last: 0, record: 0},
        damage_taken: {total: 0, last: 0, record: 0},
        kda_last: {kills: 0, deaths: 0, assists: 0},
        kda_record: {kills : 0, deaths: 0, assists: 0},
        kda_total: {kills: 0, deaths: 0, assists: 0}
    }
    focus_tree = [
    {
        focus_id: "старт",
        focus_name: "Сильное начало",
        focus_description: "+10% к урону",
        focus_cost: 100,
        focus_prerequisites: [],
        focus_restrictions: [],
        focus_unlocked: false,
        focus_icon: start_of_everything,
        stat_changes: [["basic_attack_perc", 0.1]],
        gives: []
    },
    {
        focus_id: "1",
        focus_name: "Фредди уров",
        focus_description: "гайс чи то фредди фазбер",
        focus_cost: 150,
        focus_prerequisites: ["старт"],
        focus_restrictions: {"and":["fстарт", "!f2"]},
        focus_unlocked: false,
        focus_icon: eueueuee,
        stat_changes: [["max_hp", 65]],
        gives: []
    },
    {
        focus_id: "2",
        focus_name: "лунаси йоууу",
        focus_description: "генерал директор оф проджкт мун",
        focus_cost: 150,
        focus_prerequisites: ["старт"],
        focus_restrictions: {"and":["fстарт", "!f1"]},
        focus_unlocked: false,
        focus_icon: limbus,
        stat_changes: [],
        gives: [["skill", template_skill]]
    },
    {
        focus_id: "e",
        focus_name: "Вайбмен Вайбс",
        focus_description: "Открывает секрет пасхалко уууу",
        focus_cost: 150,
        focus_prerequisites: ["1", "2"],
        focus_restrictions: {"and":["!fnot_e", {"or":["f1", "f2"]}]},
        focus_unlocked: false,
        focus_icon: vibeman,
        stat_changes: [],
        gives: [["transformation", hero_transformed]]
    },
    {
        focus_id: "not_e",
        focus_name: "АнтиВайбмен Вайбс",
        focus_description: "Ты против вайба? уууу",
        focus_cost: 150,
        focus_prerequisites: ["1", "2"],
        focus_restrictions: {"and":["!fe", {"or":["f1", "f2"]}]},
        focus_unlocked: false,
        focus_icon: antivibe,
        stat_changes: [["max_hp_perc", 0.2], ["max_hp", 50], ["basic_attack", 20]],
        gives: []
    },
    {
        focus_id: "финалка",
        focus_name: "Положить конец веселью",
        focus_description: "Настало время покончить с ними",
        focus_cost: 150,
        focus_prerequisites: ["not_e"],
        focus_restrictions: ["fnot_e"],
        focus_unlocked: false,
        focus_icon: final_to_vibe,
        stat_changes: [["basic_crit_damage", 1], ["basic_crit_chance", 25], ["basic_accuracy", 7]],
        gives: [["skill", template_skill]]
    },
    ]
}
else{
    if team == 1{ 
        skills_ins = []
    image_xscale = 1
    for (var i = 0; i < array_length(skills); i++){
        var skill = object_get_safe_stats_shown(skills[i])
        var a = create_item_from_template(skill, x - 64 * (i+1), y, "Instances", id)
        array_push(skills_ins, a)
        //instance_create_layer(x - 64 * (i+1), y, "Instances", skills[i], {host: id})
    }
}
else if team == 2{
    skills_ins = []
    image_xscale = -1
    for (var i = 0; i < array_length(skills); i++){
        var skill = object_get_safe_stats_shown(skills[i])
        var a = create_item_from_template(skill, x + 64 * (i+1), y, "Instances", id)
        array_push(skills_ins, a)
        //instance_create_layer(x - 64 * (i+1), y, "Instances", skills[i], {host: id})
        //instance_create_layer(x +  64 * (i+1), y, "Instances", skills[i], {host: id, image_xscale: -1})
    }
}
}
hp = max_hp
damage_dealers_to_me = []
last_hit = noone
sanity = max_sanity
chosen = 0
attack_cooldown = attack_interval
statuses_visual = []
target = noone
target_to_move = noone
need_pos = 0
moving_progress = 0
is_moving = 0
directionn = 0
healing_sanity = false
heal_timer = 0
if team == 1{
    retr_target_row = 0
    esc_target_row = -1 
}
else{
    retr_target_row = 6
    esc_target_row = 7
}
retr_speed = mov_speed * 2
crazy_speed = mov_speed * 2.5
crazy_attack_speed = attack_interval * 0.75
function find_basic_target() {
    var potential_targets = [];
    
    // Собираем всех возможных целей
    
    with (hero) {
        if ((team != other.team or state == "crazy") && hp > 0) and floor(abs(distance_to_target(other))) < other.basic_range {
            array_push(potential_targets, id);
        }
    }
    // Если есть цели - выбираем случайную
    if (array_length(potential_targets) > 0) {
        target = potential_targets[irandom(array_length(potential_targets)-1)];
        is_moving = 0
        moving_progress = 0
        target_to_move = noone
        directionn = 0
    } else {
        target = noone;
        ruleset.check_win();
        if !is_moving{
        var min_range = 999999999
        with (hero) {
        if (team != other.team && hp > 0) and abs(distance_to_target(other)) <= abs(min_range) {
            if min_range == distance_to_target(other){ 
                array_push(potential_targets, id);
            }
            else{
                potential_targets = []
                array_push(potential_targets, id);
            }
            min_range = distance_to_target(other)
            //show_debug_message(min_range)
        }}
        if array_length(potential_targets) > 0{ 
            target_to_move = potential_targets[irandom(array_length(potential_targets)-1)];   
            need_pos = pos + min_range }    
        }    

    }
}
function attack(_target, modifers=[]){
    if !instance_exists(_target){return }
    var shot = irandom(100)
    if shot >= basic_accuracy{
        _target.get_damage(0, "attack", self, 1)
        show_effect(_target, eff)
        return
    }    
    var crit = irandom(100)
    var is_crit = false
    var attack_power = basic_attack
    if crit <= basic_crit_chance{
        attack_power *= basic_crit_damage
        is_crit = true
    }
    show_debug_message("Attack:" + name + " (" + string(team) + ") базовый урон - "+ string(attack_power) + ", врага "+ _target.name + " ("+ string(_target.team) + "), оставшееся хп - " + string(_target.hp - attack_power))
    for (var j = 0; j < array_length(statuses_visual); j++){
        if statuses_visual[j].type == armor_crush{
            apply_effect(_target, fragility, {potency: statuses_visual[j].stacks[0].potency}, {duration: statuses_visual[j].stacks[0].status_duration})
        } 
    }
    if is_crit{
        show_effect(_target, crit_eff)
        _target.get_damage(attack_power, "attack", self, 0, 1)
    }
    else{
        show_effect(_target, eff)
        _target.get_damage(attack_power, "attack", self, 0, 0)
    }
    
}
function show_effect(_target, _effect){
    var a = instance_create_layer(_target.x, _target.y, "effects", effect, {sprite_index: _effect, constant: false, image_xscale: -1*_target.image_xscale, host: _target})
}
function get_damage(n, type, dealer, miss=false, crit=false, skill=noone){
    if type == "attack"{
        var dodge = irandom(100)
        if dodge <= dodge_chance{
            miss = true
        }
    }    
    if miss{
        var _miss = instance_create_layer(x + 64 * image_xscale, y + 64, "effects", damage_text);
        _miss.text = "MISS";
        _miss.color = c_gray;              // Серый = промах
        _miss.scale_max = 2.8;
        return
    }
    taking_damage_timer = 0
    var total = n
    var atk_modifer = 1
    for (var i =0; i < array_length(statuses_visual); i++){
        if statuses_visual[i].name == "fragility"{
            atk_modifer += statuses_visual[i].potency / 100
        } 
        if statuses_visual[i].name == "defense_up"{
            if atk_modifer - statuses_visual[i].potency / 100 < 0.15 and atk_modifer > 0.15{atk_modifer = 0.15}
            else if atk_modifer - statuses_visual[i].potency / 100 >= 0.15{
            atk_modifer -= statuses_visual[i].potency / 100}
            
        } 
    }
    //if atk_modifer > 1{show_message(atk_modifer)}
    change_sanity(-1, "damage", total * atk_modifer)
    hp -= total * atk_modifer
    dealer.statistics.damage.last += total * atk_modifer
    sk = skill
    if type == "skill"{
        //show_message(dealer.skills)
        dealer.skills[array_find_index(dealer.skills, function(el) {return el.variables.uid == sk; })].variables.statistics.damage.last += total * atk_modifer
    }
    statistics.damage_taken.last += total * atk_modifer
    array_push(damage_dealers_to_me, last_hit)
    last_hit = dealer
    if crit{
        var _dmg = instance_create_layer(x + 64 * image_xscale, y + 64, "effects", damage_text);
        _dmg.text = string(round(total * atk_modifer)); // Число урона
        _dmg.color = c_red;                // Красный = урон
        _dmg.scale_max = 2.5;              // Эффект "увеличения"
    }
    else{
        var _crit = instance_create_layer(x + 64 * image_xscale, y + 64, "effects", damage_text);
        _crit.text = string(round(total * atk_modifer));
        _crit.color = c_yellow;            // Желтый = крит
        _crit.scale_max = 3.0;             // Больше масштаб
        _crit.drift_speed = 2.0;  
    }
}
function distance_to_target(_target){
    var a = id
    var b = _target.id
    var an = -1
    var bn = -1
    //show_message([a, b, ruleset.battlefield])
    for (var i = 0; i < array_length(ruleset.battlefield); i++){
        if array_contains(ruleset.battlefield[i], a){
            an = i
        }
        if array_contains(ruleset.battlefield[i], b){
            bn = i
        }
    }
    if an>-1 and bn>-1{
        return (an - bn)
    }
    else{
        return 9999999
    }}


function array_find_instance(_array, instance_to_find) {
    // Проверка входящих данных
    if (!is_array(_array)) {
        show_debug_message("Ошибка: первый аргумент не массив!");
        return -1;
    }
    
    if (!instance_exists(instance_to_find)) {
        show_debug_message("Ошибка: второй аргумент не экземпляр!");
        return -1;
    }
    
    // Поиск по уникальному ID экземпляра
    var target_id = instance_to_find.id;
    
    for (var i = 0; i < array_length(_array); i++) {
        var itemm = _array[i];
        
        // Проверяем, является ли элемент экземпляром
        if (instance_exists(itemm)) {
            // Сравниваем по уникальному ID
            if (itemm.id == target_id) {
                return i; // Найден
            }
        }
    }
    
    return -1; // Не найден
}
function change_sanity(alter, type, val=0){
    if alter = -1{
        healing_sanity = 0
        if type == "damage"{
            var hp_proc = hp / max_hp * 100
            var keys = struct_get_names(damage_to_sanity.damage)
            for (var i = array_length(keys)-1; i>=0; i--){
                if hp_proc < int64(string_replace(keys[i], "hp", "")){
                    sanity -= val * damage_to_sanity.damage[$ keys[i]]
                    //show_message([hp, hp_proc, keys[i], sanity])
                    break
                }
            }
        }
        else if type == "ally_death_row"{
            sanity -= damage_to_sanity.ally_death.row
        }
        else if type == "ally_death_global"{ 
            sanity -= damage_to_sanity.ally_death.glob
        }
    }
    else{
        
    }
    check_sanity()
    show_debug_message([team, id, hp, sanity, state])
}
function check_sanity(){
    if state == "crazy" return
    var keys = struct_get_names(low_sanity_effect)
    state = "normal"
            for (var i = array_length(keys)-1; i>=0; i--){
                if sanity / max_sanity * 100 < int64(string_replace(keys[i], "s", "")){
                    state = low_sanity_effect[$ keys[i]]
                    switch_to_state(state)
                    //show_message([hp, hp_proc, keys[i], sanity])
                    break
                }
            }
}
function switch_to_state(st){
    if st == "retreat"{
        if team == 1{
            retr_speed = mov_speed * 2
            is_moving = 1
            directionn = -1
        }
        else{
            retr_target_row = 6
            retr_speed = mov_speed * 2
            is_moving = 1
            directionn = 1
        }
 
    }
    else if st == "panic"{
        if team == 1{
            is_moving = 1
            directionn = -1
        }
        else{
            is_moving = 1
            directionn = 1
        }
    }
    else if st == "crazy"{
        directionn = 0
        is_moving = 0
        find_anything_target()
        if team == 1{
            attack_cooldown = crazy_attack_speed
        }
        else{
            attack_cooldown = crazy_attack_speed
        }
    }
}
function find_anything_target(state_ex=["crazy", "panic", "retreat"]){
    var potential_targets = [];
    // Собираем всех возможных целей
    
    with (hero) {
        //show_message([id!=other.id, array_contains(state_ex, state), team != other.team, (floor(abs(distance_to_target(other))) < other.basic_range)])
        if hp > 0 and id != other.id and (!array_contains(state_ex, state) or team != other.team) and (floor(abs(distance_to_target(other))) < other.basic_range) {
            array_push(potential_targets, id);
        }
    }
    // Если есть цели - выбираем случайную
    if (array_length(potential_targets) > 0) {
        target = potential_targets[irandom(array_length(potential_targets)-1)];
        //show_debug_message(floor(abs(distance_to_target(target) + directionn)))
        is_moving = 0
        moving_progress = 0
        target_to_move = noone
        directionn = 0
    } else {
        target = noone;
        ruleset.check_win();
        if !is_moving{
        var min_range = 999999999
        with (hero) {
        if hp > 0  and id != other.id and (!array_contains(state_ex, state) or team != other.team) and abs(distance_to_target(other)) <= abs(min_range) {
            //show_message([state_ex, state, team==other.team, array_contains(state_ex, state)])   
            if min_range == distance_to_target(other){ 
                array_push(potential_targets, id);
            }
            else{
                potential_targets = []
                array_push(potential_targets, id);
            }
            min_range = distance_to_target(other)
            //show_debug_message(min_range)
        }}
        if array_length(potential_targets) > 0{ 
            target_to_move = potential_targets[irandom(array_length(potential_targets)-1)];   
            need_pos = pos + min_range }    
        }    

    }
}
// В Create Event объекта:
current_hp_display = hp;    // Текущее отображаемое значение здоровья
hp_drain_speed = 0.4;       // Скорость изменения индикатора
heal_color = c_aqua;        // Цвет индикатора лечения
damage_color = c_yellow;    // Цвет индикатора урона

function draw_my_healthbar(_x1 = x, _x2 = x+10*image_xscale, _y1 = y, _y2 = y + 128, hei=128) {
    /*var _x1 = x;
    var _x2 = x - 10 * image_xscale;
    var _y1 = y;
    var _y2 = y + 128;*/
    
    // Фон шкалы (черная рамка с красными краями)
    draw_rectangle_color(_x1, _y1, _x2, _y2, c_black, c_red, c_red, c_red, false);
    
    // Плавное изменение отображаемого здоровья
    current_hp_display = lerp(current_hp_display, hp, 0.1 * hp_drain_speed);
    
    // Рассчитываем высоты
    var display_height = hei * (current_hp_display / max_hp);
    var real_height = hei * (hp / max_hp);
    
    // Индикатор урона (желтый) - когда отображаемое здоровье больше реального
    if (current_hp_display > hp) {
        var damage_height = display_height - real_height;
        var damage_y = _y2 - display_height;
        draw_rectangle_color(
            _x1, damage_y,
            _x2, damage_y + damage_height,
            damage_color, damage_color, damage_color, damage_color, false
        );
        draw_rectangle_color(
        _x1, _y2 - real_height,
        _x2, _y2,
        c_green, c_green, c_lime, c_green, false
    );
    }
    // Индикатор лечения (голубой) - когда отображаемое здоровье меньше реального
    else if (current_hp_display < hp) {
            // Основная зеленая часть - текущее реальное здоровье
    draw_rectangle_color(
        _x1, _y2 - real_height,
        _x2, _y2,
        c_green, c_green, c_lime, c_green, false
    );
        var heal_height = real_height - display_height;
        var heal_y = _y2 - real_height;
        draw_rectangle_color(
            _x1, heal_y,
            _x2, heal_y + heal_height,
            heal_color, heal_color, heal_color, heal_color, false
        );
    }
    else{
                draw_rectangle_color(
        _x1, _y2 - real_height,
        _x2, _y2,
        c_green, c_green, c_lime, c_green, false
    );
    }
    
    // Дополнительные улучшения:
    
    // 1. Анимация пульсации при полном здоровье
    if (hp >= max_hp) {
        var pulse = 0.3 + 0.1 * sin(current_time * 0.01);
        draw_set_alpha(pulse);
        draw_rectangle_color(
            _x1, _y2 - real_height,
            _x2, _y2,
            c_green, c_green, c_white, c_lime, false
        );
        draw_set_alpha(1);
    }
    
    // 2. Тонкая белая рамка для четкости
    //draw_rectangle(_x1, _y1, _x2, _y2, false);
}
//show_message([starter_statuses, statuses_visual])
function apply_effect(_target, _effect, _params = undefined, _uparams = undefined){
    if !instance_exists(_target){return } 
    var _finder = {
    _effect: _effect,
    check: function(_item) { return _item.type == self._effect; }
}
    //show_debug_message(_target.statuses_visual)
//show_debug_message([instance_exists(_target)])    
var stat = array_find_index(_target.statuses_visual, _finder.check);
    if stat != -1{
        if _target.statuses_visual[stat].is_stackable{
            _target.statuses_visual[stat].add_params(_params, _uparams)
            //_target.statuses_visual[stat].renew_statuses(_rparams)
        }
        else{            
            instance_create_layer(0, 0, "effects", _effect, {host: _target, stackable_params:_params, unstackable_params: _uparams})}
    }
    else{
        instance_create_layer(0, 0, "effects", _effect, {host: _target, stackable_params:_params, unstackable_params: _uparams})
    }
}
for (var i = 0; i < array_length(starter_statuses); i++){
    apply_effect(self, starter_statuses[i][0], starter_statuses[i][1], starter_statuses[i][2])
}
function create_item_from_template(template, x, y, layer, _host=noone) {
// Создаем экземпляр с начальными параметрами
    var inst = instance_create_layer(x, y, layer, template.object_index, {host: _host, temp: true});
    //instance_deactivate_object(inst)
    if (!instance_exists(inst)) return noone;
    //instance_deactivate_object(inst)
    // Копируем обычные переменные
    if (variable_struct_exists(template, "variables")) {
        var vars = template.variables;
        var var_names = variable_struct_get_names(vars);
        for (var i = 0; i < array_length(var_names); i++) {
            var name = var_names[i];
            variable_instance_set(inst, name, struct_get(vars, name))
            //inst[$ name] = struct_get(vars, name)
                //show_message(vars[$ name])
        }
    }
    var instt = noone
    with inst{
        host = _host
        temp = false
        instt = instance_copy(true)
        instance_destroy()
    }
    //show_message(inst.hp)
    //inst.attack(self)
    //instance_activate_object(inst)
    // Копируем методы с привязкой контекста
    /*if (variable_struct_exists(template.reff, "methods")) {
        var methods = template.reff.methods;
        var method_names = variable_struct_get_names(methods);
        
        for (var i = 0; i < array_length(method_names); i++) {
            var m_name = method_names[i];
            inst[$ m_name] = method(inst, methods[$ m_name]);
        }
    }*/
    return instt;
}
function object_get_safe_stats_shown(obj) {
    if typeof(obj) == "struct"{
        //sprite_index = object_get_sprite(obj.object_index)
        //mask_index = object_get_mask(obj.object_index)
        return obj
    }
    sprite_index = object_get_sprite(type)
    mask_index = object_get_mask(type)
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
taking_damage_timer = 0
//show_message(statuses_visual)
statistics.damage.last = 0
statistics.damage_taken.last = 0
statistics.kda_last = {kills: 0, deaths:0, assists: 0}