global.chosen_pers = noone
function calculate_kda(kills, deaths, assists) {
    //if (deaths == 0) deaths = 1; // Чтобы избежать деления на 0
    return (kills + assists) / (deaths + 1);
}
function calculate_mvp_score(player) {
    var kda_score = calculate_kda(player.statistics.kda_last.kills, player.statistics.kda_last.deaths, player.statistics.kda_last.assists)
    var damage_score = player.statistics.damage.last / 100; // 150 урона = 1 балл
    var damage_taken_score = (player.statistics.damage_taken.last / player.max_hp) * 2; // больше урона = лучше
    //var objectives_score = player.objectives * 2; // Участие в убийствах объектов
    
    return kda_score + damage_score + damage_taken_score
}
tops1 = [] 
tops2 = []
with hero{
        var scor = other.calculate_mvp_score(self)
        ti = uid
        if team == 1{
            var in = array_find_index(other.tops1, function f(a){if a[0].uid == other.ti return true else return false})
            if in == -1{
                 array_push(other.tops1, [self, scor, uid])
            }
            else{
                other.tops1[in][1] = scor
            }
        }
        else {
            array_push(other.tops2, [self, scor, uid])
        }    
    }
    array_sort(tops1, function (a, b) {return a[1] < b[1]})
    array_sort(tops2, function (a, b) {return a[1] < b[1]})