if !instance_exists(host){
    instance_destroy(self)
}
if cd > 0{
    cd -= 1
}
if (cd <= 0 && ready == false) and instance_exists(host) and host.state == "normal" {
    ready = true;
    
    // Добавляем случайную задержку перед использованием (5-15 кадров)
    alarm[0] = irandom_range(5, 15);
}