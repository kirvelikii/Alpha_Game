if rolling{
    time += 1
    sspeed += a
    new_r = (room_width + 128) / sspeed
}
if sspeed <= 0 and rolling == 1{
    rolling = 0
    var backk = 9999999999
    var dir = 0
    for (var i = 0; i < array_length(rolling_items); i++){
            if rolling_items[i].x - win_st.x - 4 + 64 >= 0{
                if abs(rolling_items[i].x - win_st.x - 4 + 64) <= backk{
                    backk = abs(rolling_items[i].x - win_st.x - 4 + 64)
                    dir = -1}
            }
            else{
                if abs(rolling_items[i].x - win_st.x - 4 + 64) <= backk{
                    backk = abs(rolling_items[i].x - win_st.x - 4 + 64)
                    dir = 1}
            }
        }
    for (var i = 0; i < array_length(rolling_items); i++){
        rolling_items[i].x += dir * (backk)
    }
    //show_message(dir)
    win_st.alarm[0] = 60
}
if rolling and ((array_length(rolling_items) <= 8 and time >= new_r / 7) or time >= new_r){
    //show_message(time)
    if array_length(rolling_items) == 8{
        instance_destroy(rolling_items[7])
        array_delete(rolling_items, 7, 1)
        //array_delete(roll_times, 4, 1)
        //show_message(rolling_items)
    }
    var roll = 0
    for (var i=0; i<array_length(global.chests_db[$ chestt].items); i++){
        roll += global.items_db[$ global.chests_db[$ chestt].items[i]].chance
    }
    roll = random(roll)
    for (var i=0; i<array_length(global.chests_db[$ chestt].items); i++){
            roll -= global.items_db[$ global.chests_db[$ chestt].items[i]].chance
        if roll <= 0{
            //array_push(rolling_items, global.chests_db[$ chestt].items[i])
            var ss = instance_create_layer(room_width, y - 400, "Instances", gamba)
            ss.sprite_index = asset_get_index(global.items_db[$ global.chests_db[$ chestt].items[i]].texture)
            ss.mask_index = asset_get_index(global.items_db[$ global.chests_db[$ chestt].items[i]].texture)
            ss.speed = sspeed 
            ss.direction = 180
            ss.type = global.items_db[$ global.chests_db[$ chestt].items[i]]
            ss.rarity = global.items_db[$ global.chests_db[$ chestt].items[i]].rarity
            array_insert(rolling_items, 0, ss)
            //array_insert(roll_times, 0, [0, 20])
            //show_message(rolling_items)
            break
        }
        }
        time = 0
}
if rolling{
    for (var i=0; i<array_length(rolling_items); i++){ 
        //roll_times[i][0] += 1
        rolling_items[i].speed = sspeed
}}