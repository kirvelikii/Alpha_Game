// Плавное всплывание вверх
y -= drift_speed;

// Анимация масштаба (увеличение, затем уменьшение)
if (timer < life * 0.3) {
    scale = lerp(scale, scale_max, 0.2);
} else {
    scale = lerp(scale, 1.8, 0.1);
}

// Постепенное исчезновение
alpha = lerp(alpha, 0, 0.01);

// Удаление после завершения
if (timer++ >= life) {
    instance_destroy();
}