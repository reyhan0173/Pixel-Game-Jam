shader_type canvas_item;


// Secondary noise sampler to make the water more complex.
uniform sampler2D noise: repeat_enable;
// Color ramp that we multiply the color by over its lifetime.
uniform sampler2D gradient;
// Two velocity variables to scroll the textures.
uniform vec2 velocity;
uniform vec2 velocity2;

varying float lifetime;


void vertex() {
	lifetime = INSTANCE_CUSTOM.y;
}


void fragment() {
	// value is used for surrounding opacity, to make the water round.
	float value = texture(noise, UV + velocity2 * TIME).r;
	value = mix(1.0, value, 0.5);
	value *= pow(sin(UV.x * PI), 1.0);
	value *= pow(sin(UV.y * PI), 1.0);
	value = pow(value, 0.5);
	
	// Scroll two noise textures and mix them.
	vec4 texture1 = texture(TEXTURE, UV + velocity * TIME);
	vec4 texture2 = texture(noise, UV + velocity2 * TIME);
	vec4 color = mix(texture1, texture2, 0.5);
	float brightness = (color.r + color.g + color.b) / 3.0;
	
	// Assign the initial color of the final image.
	COLOR = color;
	
	// Round out the edges using value.
	if (value < 0.5) {
		COLOR.a = 0.0;
	}
	// Remove fleeting opacity values
	if (color.r < 0.2) {
		COLOR.a = 0.0;
	}
	COLOR.rgb = vec3(1.0);
	COLOR *= texture(gradient, vec2(brightness+lifetime));
	//if (COLOR.a > 0.1) {
		//COLOR.a = 1.0;
	//} else {
		//COLOR.a = 0.0;
	//}
}
