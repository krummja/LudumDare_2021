extends KinematicBody2D


export var bulletSpeed = 200
export var bulletLifetime = 5.0
var bulletTime

# Called when the node enters the scene tree for the first time.
func _ready():
	bulletTime = bulletLifetime

func _process(delta):
	var floatframe  = (bulletTime *10.00)
	var frame : int= floatframe 
	$"Sprite".set_frame((frame % 4))
	bulletTime-= delta
	if bulletTime < 0 : queue_free ( )

func _physics_process(delta):
	position += transform.x * bulletSpeed * delta

func die():
	queue_free ( )
