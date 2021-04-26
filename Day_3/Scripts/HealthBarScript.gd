tool
extends Sprite


# Declare member variables here. Examples:
export var HP : int = 100
export var MaxHP : float = 100
export var LeftBound = 10
export var RightBound = 1000



# Called when the node enters the scene tree for the first time.
func _ready():
	region_enabled = true
	pass # Replace with function body.

func _draw():
	if Engine.editor_hint: draw_line( Vector2(LeftBound,0), Vector2(RightBound,0), Color( 1, 1, 0, 1 ) ,3.0)
	pass


func _process(_delta):
	var Lifesize : float = RightBound - LeftBound
	var Lifepercent : float = HP/MaxHP
	region_rect = Rect2(0,0,RightBound-(Lifesize-(Lifesize*(Lifepercent))),texture.get_height())
	update()
	
pass


func _on_Player_UpdateBar(health):
	HP = health
	if HP < 0:
		HP = 0
		get_node("DeathSound").play()
		
		#aaaauuughhhhhh
