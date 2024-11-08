@tool
extends DialogicPortrait

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var health_per_centage: float

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)

func _process(_delta: float) -> void:
	if gpu_particles_2d == null:
		return
	
	health_per_centage = Dialogic.VAR.values.health/100.
	gpu_particles_2d.process_material.color = Color.RED.lerp(Color.GREEN, health_per_centage)

func _get_covered_rect() -> Rect2:
	return Rect2(gpu_particles_2d.position, Vector2(80, 80))
