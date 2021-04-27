extends Control
onready var mainScene

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Root.tscn")

func _on_AudioStreamPlayer_finished():
	pass

func _on_musicButton_pressed():
	get_node("CanvasLayer/musicButton/oceanMan").play()
	pass # Replace with function body.
