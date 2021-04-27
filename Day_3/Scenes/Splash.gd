extends Control

func _start_game():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_Timer_timeout():
	_start_game()
