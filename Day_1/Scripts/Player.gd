extends KinematicBody2D


export var speed = 800
export (int) var gravity = 4000
export (int) var base_oxygen = 100

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("up"):
		velocity.y -= speed / 1.5
	if Input.is_action_pressed("down"):
		velocity.y += speed / 3
	if Input.is_action_pressed("left"):
		velocity.x -= speed / 3
	if Input.is_action_pressed("right"):
		velocity.x += speed / 3

func _physics_process(delta):
	get_input()
	check_world_boundary()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func check_world_boundary():
	if position.x <= -500:
		position.x = -500
	if position.x >= 500:
		position.x = 500
	
