shader_type canvas_item;

uniform sampler2D sprite_texture: source_color, filter_linear;
uniform bool showOutline = false;
vec2 polar_coordinates(vec2 uv, vec2 center, float zoom, float repeat)
{
	vec2 dir = uv - center;
	float radius = length(dir) * 2.0;
	float angle = atan(dir.y, dir.x) * 1.0/(3.1416 * 2.0);
	return mod(vec2(radius * zoom, angle * repeat), 1.0);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = texture(TEXTURE,UV);
	if(showOutline && col.a < 0.1) {
	for(int i =8 ; i >= 0; i--) {
		vec2 px = TEXTURE_PIXEL_SIZE*float(i);
		
		float aL = texture(TEXTURE, UV + vec2(-px.x,0.0)).a;
		float aR = texture(TEXTURE, UV + vec2(px.x,0.0)).a;
		float aU = texture(TEXTURE, UV + vec2(0.0,-px.y)).a;
		float aD = texture(TEXTURE, UV + vec2(0.0,px.y)).a;
		if(aL > 0.0 || aR > 0.0 || aU > 0.0 || aD > 0.0) {
			COLOR = vec4(1.0,1.0,1.0,1.0*(2.0/float(i)));
		}
		}
	}

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
