@tool
extends DialogicPortrait

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _get_covered_rect() -> Rect2:
	return Rect2(gpu_particles_2d.position, Vector2(80, 80))
