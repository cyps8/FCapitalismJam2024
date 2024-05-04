shader_type spatial;

uniform sampler2D grass_texture : source_color;

void vertex() {
	vec3 dir = CAMERA_POSITION_WORLD - NODE_POSITION_WORLD;
	dir.y = 0.0;
	dir = normalize(dir);
	mat3 billboard = mat3(cross(vec3(0.0,1.0,0.0), dir), vec3(0.0,1.0,0.0), dir);
	VERTEX = billboard * VERTEX;
	NORMAL = dir;
}

void fragment() {
	vec4 texture_color = texture(grass_texture, UV);
	ALBEDO = texture_color.xyz;
	ALPHA = texture_color.w;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
