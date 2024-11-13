shader_type canvas_item;

// works better as a normal with warping
uniform sampler2D warp_texture: repeat_enable;

uniform float intensity: hint_range(0.0, 0.3) = 0.01;
uniform vec4 tint_color: source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float tint_amount: hint_range(0.0, 1.0) = 0.4;
uniform float radius: hint_range(0.0, 1.0) = 0.4;

float bigger_than_radius(float d, float r) {
	if (d > r) {
		return 1.;
	} else {
		return 0.;
	}
}
void fragment() {
	// get a random-ish value for some speckle noise
    float noise = fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453);

    // get our normal warp
    vec2 warp = texture(warp_texture, UV).xy - 0.5;
    // sample based on warp and intensity and blur based on intensity
    vec4 screen = textureLod(TEXTURE, UV + warp * intensity * (2.*sin(TIME)), intensity * 4.0);
    // tint our image
    screen = mix(screen, tint_color, tint_amount);
	// Make round
	float distance_to_center = 1. - distance(vec2(.5, .5), UV)/0.7071067812;
    screen = mix(vec4(0.,0.,0.,0.), screen, distance_to_center);
    screen = mix(vec4(0.,0.,0.,0.), screen, bigger_than_radius(distance_to_center, radius));
	

    // light diffusion for glass shape highlights
    float diff = max(dot(warp, normalize(vec2(1.0, 1.0))), 0.0) ;
    // apply diffusion based on intensity
    screen += diff * intensity;
    // apply speckle noise based on intensity
    screen += noise * intensity;
    // yarp
    COLOR = screen;
}