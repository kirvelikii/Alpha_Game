char_page_ruleset.skill_chosen = self
for (var i = 0; i < array_length(reff.variables.effects_on_use); i++){
    var ef = reff.variables.effects_on_use[i]
    var rew = object_get_safe_stats_shown(ef[0])
    instance_create_layer(400 + 32 * i, 425, "UI", eff_showcase, {host:other, origin: rew, stats:ef})}