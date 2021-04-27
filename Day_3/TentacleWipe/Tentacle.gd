extends Node2D

onready var end_node = get_owner()
onready var end_text = end_node.get_node("END/end/end")

var wipe_offset = 0 #hacky variable for timing
var wiping = false


func _process(delta):

	var static_pos = self.position
	if wiping == true:
		end_text.show()	
		wipe_offset += 1
		if wipe_offset < 100 : self.position = self.position + Vector2(0,-10)


#Hello Jon! Hope you are enjoying my hyper organized code!
#Please send a signal to this script and have it run the following code
