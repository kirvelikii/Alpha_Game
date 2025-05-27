if fight_stats.opened{
    fight_stats.opened = 0
    ruleset.sdvg = 0
    y = 1088
}
else{
    fight_stats.opened = 1
    y = 736
    ruleset.sdvg = 200
}
ruleset.check_spaces()