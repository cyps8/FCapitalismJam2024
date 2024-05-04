shader_type spatial;

uniform sampler2D grass_texture : source_color;
uniform float start_angle : hint_range(0.0, 3.14) = 0.0;

void vertex() {
	// billboarding the texture to always face the camera
	vec3 dir_1 = CAMERA_POSITION_WORLD - NODE_POSITION_WORLD;
	dir_1 = normalize(dir_1);
	
	vec3 dir_2 = vec3(dir_1.x, 0.0, dir_1.z);
	dir_2 = normalize(dir_2);
	
	vec3 cross_1 = cross(vec3(0.0,1.0,0.0), dir_2);
	mat3 billboard = mat3(cross_1, -dir_1, cross(cross_1, dir_1));
	
	NORMAL = dir_1;
	VERTEX = billboard * VERTEX;
}

void fragment() {
	vec4 texture_color = texture(grass_texture, UV);
	ALBEDO = texture_color.xyz;
	ALPHA = texture_color.w;
}
