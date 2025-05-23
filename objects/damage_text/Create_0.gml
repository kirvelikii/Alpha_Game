text = "0";          // Текст (число или "MISS")
color = c_red;       // Цвет по умолчанию (красный = урон)
fade_time = 1.0;     // Время до исчезновения (в секундах)
drift_speed = 1.0;   // Скорость всплывания
scale = 2;         // Начальный масштаб
scale_max = 3.5; 
alpha = 1;
timer = 0;
life = 60 * fade_time; // Время жизни в кадрах
alarm[0] = 1
randomize()