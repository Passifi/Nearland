shader_type canvas_item;

uniform vec4 color : source_color = vec4(0.2, 0.9, 1.0, 0.7);
uniform float speed = 6.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    float a = tex.a;

    float shimmer = 0.9 + 0.3 * sin(TIME * speed + UV.x * 4.0 + UV.y * 5.0);
    COLOR = vec4(tex.rgb * shimmer, color.a * a);
}
void vertex() {
	// Called for every vertex the material is visible on.
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
