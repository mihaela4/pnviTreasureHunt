shader_type canvas_item;

void fragment() {
    vec2 tex_size = vec2(textureSize(TEXTURE, 0));
    vec2 uv = FRAGCOORD.xy / tex_size;
    
    vec4 color = vec4(0.0);
    float blur_size = 50.0 / tex_size.x; // Adjust blur intensity

    for(float i = -2.0; i <= 2.0; i++) {
        for(float j = -2.0; j <= 2.0; j++) {
            vec2 offset = vec2(i, j) * blur_size;
            color += texture(TEXTURE, uv + offset);
        }
    }
    
    COLOR = color / 25.0;
}

