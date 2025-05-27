with hero{
        other.schet[team-1] += 1
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
            var in = array_find_index(other.tops2, function ff(a){if a[0].uid == other.ti return true else return false})
            if in == -1{
                 array_push(other.tops2, [self, scor, uid])
            }
            else{
                other.tops2[in][1] = scor
            }
           }
    }
