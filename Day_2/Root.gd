extends Node2D

onready var player = get_node("Entities/Player")
onready var darkness = get_node("Darkness")
onready var tween = get_node("Tween")
onready var gui = get_node("CanvasLayer/GUI")

enum Depth {DEPTH_1, DEPTH_2, DEPTH_3, DEPTH_4, DEPTH_5}
var depth_state = Depth.DEPTH_1

func _process(_delta):
	var player_position = player.position
	var player_sprite = player.get_node("Sprite")
	var player_light = player.get_node("Light2D")
	var player_camera = player.get_node("Camera2D")
	
	gui.get_node("Label").text = String(floor(player_position.x)) + "  " + String(floor(player_position.y))
	
	# DEPTH 1
	if 0 < player_position.y and player_position.y < 3000:
		depth_state = Depth.DEPTH_1
		darkness.set_color(Color( 1.0, 1.0, 1.0, 1.0 ))
		player_sprite.modulate = Color( 0.52, 0.52, 0.52, 1.0 )
		
	# DEPTH 2	
	if 3001 < player_position.y and player_position.y < 6000:
		depth_state = Depth.DEPTH_2
		tween.interpolate_property(
			darkness, "color",
			darkness.color, Color( 0.8, 0.8, 0.8, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		
		tween.interpolate_property(
			player_sprite, "modulate",
			player_sprite.modulate, Color( 0.67, 0.67, 0.67, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		tween.start()
		
	# DEPTH 3
	if 6001 < player_position.y and player_position.y < 9000:
		depth_state = Depth.DEPTH_3
		tween.interpolate_property(
			darkness, "color", 
			darkness.color, Color( 0.6, 0.6, 0.6, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		
		tween.interpolate_property(
			player_sprite, "modulate",
			player_sprite.modulate, Color( 0.67, 0.5, 0.5, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		tween.start()
		
	# DEPTH 4
	if 9001 < player_position.y and player_position.y < 12000:
		depth_state = Depth.DEPTH_4
		tween.interpolate_property(
			darkness, "color", 
			darkness.color, Color( 0.6, 0.4, 0.4, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		
		tween.interpolate_property(
			player_sprite, "modulate",
			player_sprite.modulate, Color( 0.8, 0.3, 0.3, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		tween.start()
		
	# DEPTH 5
	if 12001 < player_position.y and player_position.y < 15000:
		depth_state = Depth.DEPTH_5
		tween.interpolate_property(
			darkness, "color", 
			darkness.color, Color( 0.4, 0.2, 0.2, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		
		tween.interpolate_property(
			player_sprite, "modulate",
			player_sprite.modulate, Color( 0.9, 0.3, 0.3, 1.0 ), 1.0,
			tween.TRANS_LINEAR, tween.EASE_IN_OUT
		)
		tween.start()
		
	if player_position.y > 18500:
		player_camera.limit_left = -1000
		player_camera.limit_right = 1000
