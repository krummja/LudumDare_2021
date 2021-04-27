extends KinematicBody2D

export var speed = 800
export (int) var gravity = 4000
export (int) var base_oxygen = 100
export (PackedScene) var attackHitbox
export (PackedScene) var Blood
export (PackedScene) var Bigblood
var attack_cooldown = 0.3 #wanted to export this but it's tied to animation
var current_cooldown : float = attack_cooldown

var health = 100;
var velocity = Vector2.ZERO
var zap_offset = -55
var invincible = 0.0 #invicibility countdown after getting hit
signal UpdateBar #update healthbar
onready var root = get_owner()

func _ready():
	emit_signal("UpdateBar",health)
	
func get_input():
	
	var sprite = get_node( "Sprite" )
	var hit = get_node( "Attack" )
	velocity.x = 0
	velocity.y = 0
	
	if health > 0:
		if Input.is_action_pressed("up"):
			velocity.y -= speed / 1.5
		if Input.is_action_pressed("down"):
			velocity.y += speed / 3
		if Input.is_action_pressed("left"):
			velocity.x -= speed / 3
			hit.set_flip_h( false )
			sprite.set_flip_h( false )
			zap_offset = -55
		if Input.is_action_pressed("right"):
			velocity.x += speed / 3
			hit.set_flip_h( true )
			sprite.set_flip_h( true )
			zap_offset = 55
		if Input.is_action_just_pressed("attack"):
			attack()
		if Input.is_action_pressed("to_end"):
			position = Vector2(0, 18500)
			

func _physics_process(delta):
	get_input()
	check_world_boundary()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _process(delta):
	invincible -= delta 
	if current_cooldown > 0 : current_cooldown -= delta
	if current_cooldown > -100 && current_cooldown <= 0:
		idle()
	
	#Handle Death
	if health <=0 : $"Attack".texture.set_current_frame(0)
	if health <=0 : $"Sprite".texture.set_current_frame(0)
	
	
		
func check_world_boundary():
	if position.y <= 100:
		position.y = 100
#	if position.x <= -500:
#		position.x = -500
#	if position.x >= 500:
#		position.x = 500
	
	
#Animation functions	


func idle():
	$"Sprite".visible = true 
	$"Attack".visible = false
	current_cooldown = -200


func attack():
	if current_cooldown <= 0:		
		var attack = attackHitbox.instance()
		add_child(attack)
		attack.position += Vector2(zap_offset,-15)
		$"Sprite".visible = false 
		$"Attack".visible = true
		$"Attack".texture.set_current_frame(0)
		current_cooldown = attack_cooldown


func takeDamage(damage : int):
	if invincible < 0:
		health -= damage
		var blood= Blood.instance()
		owner.add_child(blood)
		blood.position = self.position
		emit_signal("UpdateBar",health)
		invincible = 1
	
	if health <= 0:
		var bigblood= Bigblood.instance()
		owner.add_child(bigblood)
		bigblood.position = self.position
		
		


func _on_HitBox_body_entered(body):
	if body.get_collision_layer() == 65: takeDamage(10)
	if body.get_collision_layer() == 68:
		takeDamage(10)
		body.die()
