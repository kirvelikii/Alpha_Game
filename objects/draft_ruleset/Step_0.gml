if !full and array_length(global.chars[0]) == global.teams[0] and array_length(global.chars[1]) == global.teams[1]{
    full = true
    instance_create_depth(512 + 32, 512, 0, go)
} 