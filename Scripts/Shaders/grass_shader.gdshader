shader_type spatial;

uniform sampler2D grass_texture : source_color;

void vertex() {
	vec3 dir_1 = CAMERA_POSITION_WORLD - NODE_POSITION_WORLD;
	NORMAL = dir_1;
	vec3 dir_2 = vec3(dir_1.x, 0.0, dir_1.z);
	vec3 cross_1 = -cross(vec3(0.0,1.0,0.0), dir_1);
	dir_2 = normalize(dir_2);
	mat3 billboard = mat3(cross(dir_2, cross_1), dir_1, cross_1);
	VERTEX = billboard * VERTEX;
}

void fragment() {
	vec4 texture_color = texture(grass_texture, UV);
	//ALBEDO = texture_color.xyz;
	//ALPHA = texture_color.w;
}
