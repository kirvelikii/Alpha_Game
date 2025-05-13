sprite_index = data.texture
image_xscale = 0.5
image_yscale = 0.5
is_dragging = false;
drag_offset_x = 0;
drag_offset_y = 0;
type = item
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
if data.type = "stat_up"{
        for (var i = 0; i < array_length(data.effect); i++){
            //show_message(targ.reff)
            stats_shown[$ (data.effect[i][0])] = string(data.effect[i][1])}
}
//show_message(stats_shown)