varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float blink_intensity;

void main() {
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 white_mix = mix(color.rgb, vec3(1.0), blink_intensity);
    gl_FragColor = vec4(white_mix, color.a) * v_vColour;
}