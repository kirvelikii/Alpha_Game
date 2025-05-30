/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
d -= 1

    for (var i = 0; i < array_length(active_skills); i++){ 
        if d <= 0{
            d = del
    if instance_exists(active_skills[i][0]){
        active_skills[i][0].get_damage(skill_power, "skill", host, 0, 0, uid)
    }}
    active_skills[i][1] -= 1
    if active_skills[i][1] <= 0{
        array_delete(active_skills, i, 1)
    }
}
