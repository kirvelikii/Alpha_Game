name = "Template Skill"
description = "Данный текст показывает, что вы либо наткнулись на баг, либо тестировщик, либо господин разработчик, иначе.. вы ГРЯЗНЫЙ ХАКЕР"
skill_power = 10
range = 2
target_type = "Враг"
sub_target_count = 1
damage_to_targets = [1]
crit_chance = 10
crit_damage = 2
cooldown = 60 * 2
cast_delay = [5, 10]
animation_delay = 5
ready = false
cd = cooldown
restrictions = []
target = noone
sub_targets = []
eff = basic_skill_effect
effects_on_use = [[fragility, "main_target_enemy", {potency:5}, {duration:120}]]
function use_skill(_target, main_target=true, modifers = undefined){
    if !instance_exists(_target){return }
    var crit = irandom(100)
    var attack_power = skill_power * modifers.sub_target_modifer
    if crit <= crit_chance{
        attack_power *= crit_damage
    }
    show_debug_message(host.name + " (" + string(host.team) + ")" + " использует " + name + " урон - "+ string(attack_power) + ", врага "+ _target.name + " ("+ string(_target.team) + "), оставшееся хп - " + string(_target.hp - attack_power) + " " + string(_target.pos - host.pos) + " дальность")
    _target.get_damage(attack_power, "skill", host)
    for (var i = 0; i < array_length(effects_on_use); i++){
        if effects_on_use[i][1] == "target_and_sub_enemy" or (main_target and effects_on_use[i][1] == "main_target_enemy") or (!main_target and effects_on_use[i][1] == "sub_target_enemy"){ 
            apply_effect(_target, effects_on_use[i][0], effects_on_use[i][2], effects_on_use[i][3])
        }
    }
}    
function draw_skill_cooldown(x, y, size, progress, color) {
    var center_x = x + size/2;
    var center_y = y + size/2;
    var radius = size * 0.5; // 80% от размера иконки

    // 1. Полное затемнение (только если есть КД)
    if (progress < 1) {
        // 2. Темный фон (чем меньше progress, тем темнее)
        var darkness = lerp(0.3, 0.7, 1 - progress);
        draw_set_color(color);
        draw_set_alpha(darkness);
        draw_rectangle(x, y, x + size, y + size, false);
        
        // 3. "Вырезаем" прогресс белым цветом
        gpu_set_blendmode(bm_add);
        draw_set_color(c_white);
        
        // Сектор прогресса (по часовой стрелке сверху)
        var start_angle = -90;
        var end_angle = start_angle + 360 * progress;
        
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(center_x, center_y); // Центр
        
        for (var angle = start_angle; angle <= end_angle; angle += 10) {
            var px = center_x + lengthdir_x(radius, angle);
            var py = center_y + lengthdir_y(radius, angle);
            draw_vertex(px, py);
        }
        
        draw_vertex(center_x, center_y);
        draw_primitive_end();
        
        // 4. Восстанавливаем настройки
        gpu_set_blendmode(bm_normal);
        draw_set_alpha(1);
    }

}
function find_target(n_sub_targets, _priority="hp"){
    var potential_targets = [];
    var tem = host.team
    var sub = n_sub_targets - 1
    // Собираем всех возможных целей
    with (hero) {
        if (team != tem && hp > 0) and other.distance_to_target(self, other.host) < other.range{
            array_push(potential_targets, id);
        }
    }
    target = noone
    sub_targets = []
    while array_length(potential_targets) > 0 and (n_sub_targets > array_length(sub_targets) + 1 or target == noone){
        var chos = irandom(array_length(potential_targets)-1)
        if target == noone{
            target = potential_targets[chos];
            array_delete(potential_targets, chos, 1)
        }
        else{
            array_push(sub_targets, potential_targets[chos])
            array_delete(potential_targets, chos, 1)
        }
    } 
    //show_message([target, sub_targets])
    }  
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
function show_effect(_target, _effect){
    if !instance_exists(_target){return }
    var a = instance_create_layer(_target.x, _target.y, "effects", effect, {sprite_index: eff, constant: false, image_xscale: _target.image_xscale, host: _target})
}
function distance_to_target(_target, _host){
    var a = _host
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

icon_size = 64;
margin = 10;
start_x = margin;
start_y = display_get_gui_height() - icon_size - margin;
