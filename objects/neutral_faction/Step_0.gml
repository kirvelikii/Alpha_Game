if room == fight and global.mappos + 5 == army_pos{
    timer--
    if timer <= 0 and !invaded{
        invade()
    }
}
