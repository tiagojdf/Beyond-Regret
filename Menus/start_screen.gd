class_name StartScreen extends Control

const template_version: String = "0.1"
@onready var title: Label = $Title

const HEARTBEAT: AudioStream = preload("res://assets/sounds/heartbeat.ogg")
var music_player: AudioStreamPlayer

# These 4 lines are not covered in the initial video. They've been added here just to make it easier for you
# to differentiate versions. I had not intended to provide updates so this feature was skipped in original code.
@onready var version_num: Label = %VersionNum
var tween: Tween
func _ready() -> void:
	version_num.text = "v%s" % template_version
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	music_player.stream = HEARTBEAT
	add_child(music_player)
	music_player.play()

	tween = get_tree().create_tween()
	tween.tween_property(title, "scale", Vector2(1.05, 1.05), .3).set_trans(Tween.TRANS_BOUNCE)
	tween.chain().tween_property(title, "scale", Vector2(1, 1), .45).set_trans(Tween.TRANS_BOUNCE)
	tween.set_loops()

func _exit_tree() -> void:
	tween.kill()

func _on_start_button_up() -> void:
	SceneManager.swap_scenes(SceneRegistry.levels["game_start"],get_tree().root,self,"wipe_to_right")	

func _on_settings_button_up() -> void:
	Globals.open_settings_menu()

func _on_quit_button_up() -> void:
	# todo add confirmation dialog before quitting
	get_tree().quit()


func _on_credits_button_up() -> void:
	SceneManager.swap_scenes(SceneRegistry.main_scenes["CreditsScreen"],get_tree().root,self,"wipe_to_right")	
