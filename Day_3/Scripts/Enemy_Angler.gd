extends KinematicBody2D
tool

# Angler has 4 modes
# 0 = Sleep
# 1 = Windup
# 2 = Shoot
# 3 = Move - picks a random point between it and the player and attempts to reach it

var mode = 0
var cooldown = -1
export var speed = 200
export var wakeradius : int = 200 #This radius currently does nothing. should maybe adjust collider instead
var Bullet = preload("res://Entities/Projectile_Zap.tscn")
var Corpse = preload("res://Entities/AnglerCorpse.tscn")

var bulletoffset = 50
var velocity = Vector2(0,0)
var targetPlayer = null
var targetLoc = Vector2(0,0)

func ready():
	get_node("CollisionShape2D/WakeCollider/CollisionShape2D")
	pass 


func _draw():
	pass


func _process(delta):
	update()
	if cooldown == 0:
		if mode == 1:
			mode = 2 #Switch to moving
			$"Sprite/Idle".visible = true
			$"Sprite/Attack".visible = false
			cooldown = 2
		elif mode == 2:
			mode = 3 #Switch to shooting
			$"Sprite/Idle".visible = false
			$"Sprite/Attack".visible = true
			$"Sprite/Attack".texture.set_current_frame(0)
			cooldown = 0.2
		elif mode == 3:
			mode = 1 #Switch to shooting
			cooldown = 0.7
			shoot();
			
	
	#Decrease the cooldown
	if cooldown > 0 : 
		cooldown -= delta
		if cooldown < 0: cooldown = 0
		
	#Move mode
	if targetPlayer:
		targetLoc = targetPlayer.position
	if mode == 2:
		#Movement Ease in / Ease out
		var blend :float = blendAnimation(cooldown)
		velocity = position.direction_to(targetLoc) * speed * blend
		if velocity.x < 0 : $"Sprite/Idle".set_flip_h( false )
		if velocity.x > 0 : $"Sprite/Idle".set_flip_h( true )
		if velocity.x < 0 : $"Sprite/Attack".set_flip_h( false )
		if velocity.x > 0 : $"Sprite/Attack".set_flip_h( true )
		if velocity.x > 0 : bulletoffset = 50
		if velocity.x < 0 : bulletoffset = -50		
	#Shoot mode	
	if mode == 1:
		velocity = Vector2(0,0)
		
	move_and_slide(velocity,Vector2(0,-1))


func _on_WakeCollider_body_entered(body): #Due to collision masks, this can only be the player!
	if mode == 0:
		targetPlayer= body
		targetLoc = targetPlayer.position
		mode = 1 #Wake up and shoot
		cooldown = 1


func blendAnimation(t):
	return -(t * t) + (t*2)

func shoot():
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.position = self.position+Vector2(bulletoffset,-25)
	var aim = targetPlayer.position - self.position
	if targetPlayer: bullet.rotation = aim.angle()
	
func die():
	var corpse = Corpse.instance()
	call_deferred("add_to_owner", corpse)
	corpse.position = self.position
	queue_free ( )

func add_to_owner(corpse):
	owner.add_child(corpse)

func _on_Death_Collider_area_entered(area):
	die()
	
