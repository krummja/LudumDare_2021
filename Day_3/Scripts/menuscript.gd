extends Control
onready var mainScene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Root.tscn")
	#$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	pass


func _on_musicButton_pressed():
	get_node("CanvasLayer/musicButton/oceanMan").play()
	pass # Replace with function body.
