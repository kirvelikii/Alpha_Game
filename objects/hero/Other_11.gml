if !temp{
    statistics.damage.total += statistics.damage.last
statistics.damage.record = max(statistics.damage.record, statistics.damage.last)
statistics.damage_taken.total += statistics.damage_taken.last
statistics.damage_taken.record = max(statistics.damage_taken.record, statistics.damage_taken.last)
statistics.kda_total.kills += statistics.kda_last.kills
statistics.kda_total.deaths += statistics.kda_last.deaths
statistics.kda_total.assists += statistics.kda_last.assists
statistics.kda_record.kills = max(statistics.kda_record.kills, statistics.kda_last.kills)
statistics.kda_record.deaths = max(statistics.kda_record.deaths, statistics.kda_last.deaths)
statistics.kda_record.kills = max(statistics.kda_record.kills, statistics.kda_last.kills)
expp += statistics.kda_last.kills * 100
for (var i = 0; i < array_length(skills); i++){
    skills[i].variables.statistics.damage.total += skills[i].variables.statistics.damage.last
    skills[i].variables.statistics.damage.record = max(skills[i].variables.statistics.damage.record, skills[i].variables.statistics.damage.last)
}
}
