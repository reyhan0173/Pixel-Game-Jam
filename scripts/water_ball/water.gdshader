shader_type canvas_item;


uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;


uniform sampler2D noise1: repeat_enable;
uniform sampler2D noise2: repeat_enable;
uniform vec2 scroll1 = vec2(0.025, -0.015);
uniform vec2 scroll2 = vec2(-0.01, 0.01);

uniform vec4 color: source_color;


void fragment() {
	// scroll two noises across time and multiply them.
	float noise = texture(noise1, SCREEN_UV + scroll1 * TIME).r * texture(noise2, SCREEN_UV + scroll2 * TIME).r;
	// sample the screen texture, but the point of sampling is distorted by the noise.
	vec4 screen_color = texture(screen_texture, SCREEN_UV + 0.05 * vec2(noise));
	// mix in a blue hue.
	COLOR = mix(screen_color, color, 0.3);
	
	// round out the edges.
	noise = pow(noise, 0.7);
	noise *= pow(sin(UV.x * PI / 4.0), 1.0);
	noise *= pow(sin(UV.y * PI / 4.0), 1.0);
	if (noise < 0.1) {
		COLOR.a = 0.0;
	}
}
