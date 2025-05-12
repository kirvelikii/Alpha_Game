varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float blink_intensity; // 0.0-1.0
uniform vec3 blink_color;     // RGB цвет мерцания [0.0-1.0]

void main() {
    vec4 tex_color = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 color_mix = mix(tex_color.rgb, blink_color, blink_intensity);
    gl_FragColor = vec4(color_mix, tex_color.a) * v_vColour;
}