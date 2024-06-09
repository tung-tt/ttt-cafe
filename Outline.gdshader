shader_type canvas_item;

uniform vec4 outline_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_size = 1.0;

void fragment() {
    vec4 texcolor = texture(TEXTURE, FRAGCOORD.xy / TEXTURE_PIXEL_SIZE);
    if (texcolor.a < 0.1) {
        for (float x = -outline_size; x <= outline_size; x++) {
            for (float y = -outline_size; y <= outline_size; y++) {
                vec4 sample = texture(TEXTURE, (FRAGCOORD.xy + vec2(x, y)) / TEXTURE_PIXEL_SIZE);
                if (sample.a > 0.1) {
                    texcolor = outline_color;
                }
            }
        }
    }
    COLOR = texcolor;
}
