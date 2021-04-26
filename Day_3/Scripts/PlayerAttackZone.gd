extends Node

var lifetime = 0.30

func _ready():
	pass 


func _process(delta):
	lifetime -= delta
	$"Sprite".set_frame(6-((lifetime/0.30)*6))
	if lifetime > 0.25 : $"Sprite".set_frame(7) #hidden frame at start
	if lifetime < 0 : queue_free ( )
