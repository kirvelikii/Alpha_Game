drag_obj = noone
if drag_obj == noone{
    drag_obj = collision_point(mouse_x, mouse_y, pre_fight_hero, false, true);
}

    
if (drag_obj != noone){
    drag_obj.is_dragging = true;
    drag_obj.drag_offset_x = drag_obj.x - mouse_x;
    drag_obj.drag_offset_y = drag_obj.y - mouse_y;
    drag_obj.depth = -100
    }
else{
    drag_obj = collision_point(mouse_x, mouse_y, item, false, true);
    if (drag_obj != noone){
        drag_obj.is_dragging = true;
        drag_obj.drag_offset_x = drag_obj.x - mouse_x;
        drag_obj.drag_offset_y = drag_obj.y - mouse_y;
        drag_obj.depth = -100
    }
}