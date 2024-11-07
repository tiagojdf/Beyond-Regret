extends Node2D

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(.05,.05,.1))
	Dialogic.start('main')
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended() -> void:
	get_tree().quit()
