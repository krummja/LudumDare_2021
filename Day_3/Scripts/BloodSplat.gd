extends Particles2D


var life = 5



# Called when the node enters the scene tree for the first time.
func _ready():
	self.emitting = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	life -= delta
	if life < 0 : queue_free ( )
