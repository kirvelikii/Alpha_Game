tops = [{damage: [noone, 0], damage_taken: [noone, 0], kda: [noone, 0], mvp:[noone, 0]}, {damage: [noone, 0], damage_taken: [noone, 0], kda: [noone, 0], mvp:[noone, 0]}]
function calculate_kda(kills, deaths, assists) {
    //if (deaths == 0) deaths = 1; // Чтобы избежать деления на 0
    return (kills + assists) / (deaths + 1);
}
function calculate_mvp_score(player) {
    var kda_score = player.kda * 2
    var damage_score = player.damage_dealt / 100; // 150 урона = 1 балл
    var damage_taken_score = (player.damage_taken / player.max_hp) * 2; // больше урона = лучше
    //var objectives_score = player.objectives * 2; // Участие в убийствах объектов
    
    return kda_score + damage_score + damage_taken_score
}
mvp = [noone, 0]
for (var xx = 0; xx < 2; xx++){
for (var t = 0; t < 3; t++){
for (var i = 0; i<array_length(global.layout[xx][t]); i++){
    var damage = global.layout[xx][t][i].reff.variables.statistics.damage.last
    var taken = global.layout[xx][t][i].reff.variables.statistics.damage_taken.last
    var kda = calculate_kda(global.layout[xx][t][i].reff.variables.statistics.kda_last.kills, global.layout[xx][t][i].reff.variables.statistics.kda_last.deaths, global.layout[xx][t][i].reff.variables.statistics.kda_last.assists)
    var stats = {kda: kda, damage_dealt: damage, damage_taken: taken, max_hp: global.layout[xx][t][i].reff.variables.max_hp}
    var sco = calculate_mvp_score(stats)
    if damage > tops[xx].damage[1] or tops[xx].damage[0] == noone{
        tops[xx].damage = [global.layout[xx][t][i], damage] 
    }
    if taken > tops[xx].damage_taken[1] or tops[xx].damage_taken[0] == noone{
        tops[xx].damage_taken = [global.layout[xx][t][i], taken] 
    }
    if kda > tops[xx].kda[1] or tops[xx].kda[0] == noone{
        tops[xx].kda = [global.layout[xx][t][i], kda] 
    }
    if sco > tops[xx].mvp[1] or tops[xx].mvp[0] == noone{
        tops[xx].mvp = [global.layout[xx][t][i], sco]
    }
    if sco > mvp[1] or mvp[0] == noone{
        mvp = [global.layout[xx][t][i], sco]
    }
    if global.layout[xx][t][i].reff.variables.team == global.winner{
        global.layout[xx][t][i].reff.variables.expp += 150
    }
    else{
        global.layout[xx][t][i].reff.variables.expp += 50
    }
}
}}
tops[0].mvp[0].reff.variables.expp += 150
tops[1].mvp[0].reff.variables.expp += 150
tops[0].damage[0].reff.variables.expp += 100
tops[1].damage[0].reff.variables.expp += 100
tops[0].damage_taken[0].reff.variables.expp += 100
tops[1].damage_taken[0].reff.variables.expp += 100