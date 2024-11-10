@tool
extends DialogicPortrait

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var health_per_centage: float

var original_process_material: ParticleProcessMaterial

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
	
	original_process_material = gpu_particles_2d.process_material.duplicate()

func _exit_tree() -> void:
	if tween != null:
		tween.kill()

func _process(_delta: float) -> void:
	if gpu_particles_2d == null:
		return
	
	update_portrait()

func _get_covered_rect() -> Rect2:
	return Rect2(gpu_particles_2d.position, Vector2(80, 80))

var tween: Tween

func update_portrait() -> void:
	health_per_centage = Dialogic.VAR.values.health/100.
	var process_material : ParticleProcessMaterial = gpu_particles_2d.process_material

	tween = get_tree().create_tween()
	tween.tween_property(process_material, "color", Color.RED.lerp(Color.GREEN, health_per_centage), .3)
	tween.tween_property(process_material, "scale_min", original_process_material.scale_min * (.5 + health_per_centage), .3)
	tween.tween_property(process_material, "scale_max", original_process_material.scale_max * (.5 + health_per_centage), .3)
