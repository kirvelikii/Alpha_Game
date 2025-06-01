global.chars = [[], []] //список выбранных персонажей
global.charlist = [sp_hero, sp_warrior, sp_archer] //список доступных персонажей, в виде их спрайтов
global.draftlist = [] //список объектов - персонажей лоя выбора
allow_copy = 1 // булевая переменная, разрешающая брать одинаковых персонажей
for (var i=0; i<array_length(global.charlist); i++){
    var a = instance_create_depth(512+(i%3)*128*0.8, 64+floor(i/3)*128*0.8, -100, avatar) // создание и размещение - объекта - аватара
    a.sprite_index = global.charlist[i]
    a.image_xscale = 0.7
    a.image_yscale = 0.7
    array_push(global.draftlist, a)
}
turn = 1 // определяет, чей ход выбора
full = false // готовность начать игру