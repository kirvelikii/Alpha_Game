if host.chosen{
    draw_self()
if (!ready) {
    var progress = 1 - (cd / cooldown);
    draw_skill_cooldown(x - 64 * ((1-image_xscale) / 2), y, icon_size, progress, c_black);
    }
if (!ready) {
    var seconds = ceil(cd / 60);
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x + icon_size/2  * image_xscale, y + icon_size/2, string(seconds));
    }
}