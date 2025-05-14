
hover_scale = 1.1;      // Масштаб при наведении
current_scale = 1;      // Текущий масштаб (инициализируем!)
target_scale = 1;       // Целевой масштаб
is_mouse_over = false;  // Флаг наведения
focus_unlocked = false
mask_index = focus_mask
stats_shown = {
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
    max_hp_perc: 0,
    basic_attack_perc: 0,
    basic_range_perc: 0,
    attack_interval_perc: 0,
    basic_accuracy_perc: 0,
    basic_crit_chance_perc: 0,
    basic_crit_damage_perc: 0,
    dodge_chance_perc: 0,
    mov_speed_perc: 0,
    max_sanity_perc: 0
}
for (var i = 0; i < array_length(stat_changes); i++){
            //show_message(targ.reff)
            stats_shown[$ (stat_changes[i][0])] = stat_changes[i][1]}
function can_unlock() {
    if (global.player_exp < focus_cost) return false;
     for (var i = 0; i<array_length(focus_restrictions); i++ ){
        //if i != 0{show_message(0)}        
        for (var j = 0; j < array_length(focus_restrictions[i]); j++){
            if !string_starts_with(focus_restrictions[i][j], "!"){
                if string_starts_with(focus_restrictions[i][j], "f"){
                    //show_message(focus_restrictions[i][j])
                    var cl = c_red
                    var need = string_copy(focus_restrictions[i][j], 2, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                cl = c_lime
                            }
                        }
                    }
                        if cl != c_lime{if (i < array_length(focus_restrictions) - 1) {break} else {return false}}
                }
                }
                else{
                if string_starts_with(focus_restrictions[i][j], "!f"){
                    //show_message(focus_restrictions[i][j])
                    var c1 = c_lime
                    var need = string_copy(focus_restrictions[i][j], 3, string_length(focus_restrictions[i][j]))
                    with (obj_focus_block){
                        if focus_id == need{
                            if focus_unlocked{
                                c1 = c_red
                            }
                        }
                    }
                    if c1 != c_lime{if (i < array_length(focus_restrictions) - 1) {break} else {return false}}
                        
                }
            }
        }
        return true;
    }
    //show_message(0)
    return true;
}
function apply_effects(){
    var targ = starter_tree.host
    var a = struct_get_names(stats_shown)
    for (var i = 0; i < array_length(a); i++){
        if string_ends_with(a[i], "_perc"){
                targ.reff.variables[$ string_replace(a[i], "_perc", "")] *= (1 + stats_shown[$ a[i]])
                targ.reff.variables.modifer[$ string_replace(a[i], "_perc", "")] += stats_shown[$ a[i]]
            }
            else{
                //show_message(targ.reff.variables.modifer[$ a[i]])
                targ.reff.variables[$ (a[i])] += stats_shown[$ a[i]] * (1 + targ.reff.variables.modifer[$ a[i]])}
            }
    for (var i = 0; i < array_length(gives); i++){
        if gives[i][0] == "skill"{
            array_push(targ.reff.variables.skills, gives[i][1])
    }}
    }