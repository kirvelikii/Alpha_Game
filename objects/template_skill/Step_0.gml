if !instance_exists(host){
    instance_destroy(self)
}
cd -= 1
if (cd <= 0 && ready == false) {
    ready = true;
    
    // Добавляем случайную задержку перед использованием (5-15 кадров)
    alarm[0] = irandom_range(5, 15);
}