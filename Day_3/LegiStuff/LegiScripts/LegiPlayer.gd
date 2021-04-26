extends KinematicBody2D


var health = 100;
const GRAVITY = 200
const MOVE_SPEED = 200
export (PackedScene) var attackHitbox
export (PackedScene) var Blood
var attackCooldown = 0

signal UpdateBar
var invincible = 0.0

var velocity = Vector2()

func _ready():
	emit_signal("UpdateBar",health)

func _physics_process(delta):
	
	velocity.y += delta * GRAVITY
	if Input.is_action_pressed("ui_up"):
		velocity.y -= MOVE_SPEED
		
	if Input.is_action_pressed("ui_accept"):
		attack()	
	
	if velocity.y > 200: velocity.y = 200
	if velocity.y < -200: velocity.y = -200
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -MOVE_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = MOVE_SPEED
	else:
		velocity.x = 0
	move_and_slide(velocity,Vector2(0,-1))
	
	attackCooldown -= delta
	

	
	
func attack():
	if attackCooldown < 0: 
		attackCooldown = 1
		
		
		
func takeDamage(damage : int):
	if invincible < 0:
		health -= damage
		var blood= Blood.instance()
		add_child(blood)
		emit_signal("UpdateBar",health)
		invincible = 1
	


func _on_Area2D_body_entered(body):
	if body.get_collision_layer() == 65: takeDamage(10)
	if body.get_collision_layer() == 68:
		takeDamage(10)
		body.die() #This is a bit gross based on how layers are detected as combined values
