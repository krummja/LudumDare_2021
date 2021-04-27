extends Control

onready var root = get_owner()

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):	
	if get_tree().paused == false:
		get_tree().paused = true
		$Popup.popup()
		
	if Input.is_action_pressed("exit"):
		self.hide()
		get_tree().paused = false
		$Popup.hide()

func _on_Continue_pressed():
	$Popup.hide()
	get_tree().paused = false
	queue_free()

func _on_Exit_pressed():
	get_tree().quit()
