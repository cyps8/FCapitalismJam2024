shader_type spatial;
render_mode unshaded;
render_mode cull_disabled;
render_mode blend_mix;

uniform vec4 albedo: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float count = 3.0;
uniform float line_width: hint_range(0.001, 10.0) = 1.0;
uniform float speed = 1.0;

float draw_lines(float height, float num_lines, float width) 
{
	float phase = (height * num_lines + TIME * speed) * TAU;
	float line = cos(phase) * 0.5 + 0.5;
	line = pow(line, 1.0 / width);
	return line;
}

void fragment() 
{
	float height = UV.y * 2.0;
	
	ALPHA = albedo.a;
	if (count > 0.01 && line_width > 0.001) {
		ALPHA *= draw_lines(height, count, line_width);
	}
	ALPHA *= smoothstep(0.0, 1, height);
	ALPHA *= smoothstep(0.0, 0.1, 1.0 - height);
	ALBEDO = albedo.rgb;
}