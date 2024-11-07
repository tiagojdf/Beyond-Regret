extends Node2D

@onready var debug: Control = $Debug

@onready var meaning_label: Label = $Debug/VBoxContainer/MeaningLabel
@onready var connection_label: Label = $Debug/VBoxContainer/ConnectionLabel
@onready var fulfillment_label: Label = $Debug/VBoxContainer/FulfillmentLabel
@onready var legacy_label: Label = $Debug/VBoxContainer/LegacyLabel
@onready var inner_peace_label: Label = $Debug/VBoxContainer/InnerPeaceLabel
@onready var health_label: Label = $Debug/VBoxContainer/HealthLabel

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(.05,.05,.1))
	Dialogic.start('main')
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.VAR.variable_changed.connect(_on_variable_changed)
	
	# For development purposes
	if OS.is_debug_build():
		update_labels()
		debug.visible = true

func _on_variable_changed(_info: Dictionary) -> void:
	update_labels()
	
func update_labels() -> void:
	meaning_label.text = str("Meaning:", Dialogic.VAR.values.meaning)
	connection_label.text = str("Connection:", Dialogic.VAR.values.connection)
	fulfillment_label.text = str("Fulfillment:", Dialogic.VAR.values.fulfillment)
	legacy_label.text = str("Legacy:", Dialogic.VAR.values.legacy)
	inner_peace_label.text = str("Inner Peace:", Dialogic.VAR.values.inner_peace)
	health_label.text = str("Health:", Dialogic.VAR.values.health)

func _on_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	SceneManager.swap_scenes(SceneRegistry.main_scenes["CreditsScreen"],get_tree().root,self,"wipe_to_right")	
