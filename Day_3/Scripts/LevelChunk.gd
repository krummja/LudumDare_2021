extends Node2D

var CaveWall1 = preload("res://Environment/Tiles/CaveWall1.tscn")
var CaveFloor = preload("res://Environment/Tiles/CavePlatform.tscn")

const TILE_SIZE = 70
const LEFT_BOUND = -580
const RIGHT_BOUND = 490
var is_final = false

func make_chunk(_offset: int, rng: RandomNumberGenerator) -> void:
	rng.randomize()
	position = Vector2(position.x - 500, position.y + _offset)

	var top_bound = _offset
	var bottom_bound = _offset + (TILE_SIZE * 7)

	# Make left and right chunk walls
	for y in range(top_bound, bottom_bound, TILE_SIZE):
		var left_wall = CaveWall1.instance()
		left_wall.position = Vector2(LEFT_BOUND, y)
		$Tiles.add_child(left_wall)
		
		var right_wall = CaveWall1.instance()
		right_wall.position = Vector2(RIGHT_BOUND, y)
		$Tiles.add_child(right_wall)

	# Make the platform for each chunk
	make_platform(_offset, rng)

func make_platform(_y, rng: RandomNumberGenerator):
	rng.randomize()
	var opening = rand_range(2, 5)
	var start_x = 12 - opening
	var x = rng.randi_range(2, start_x)

	# Platform from LEFT_BOUND to opening
	for _x in range(1, x):
		var platform = CaveFloor.instance()
		platform.position = Vector2((_x * TILE_SIZE) + LEFT_BOUND, _y)
		$Tiles.add_child(platform)

	# Platform from opening to RIGHT_BOUND
	for _x in range(x + opening, 15):
		var platform = CaveFloor.instance()
		platform.position = Vector2((_x * TILE_SIZE) + LEFT_BOUND, _y)
		$Tiles.add_child(platform)

	# Local depth variables for the cave entrance stepping
	var left_depth = rng.randi_range(2, 4)
	var right_depth = rng.randi_range(2, 4)
	
	# Left side steps negative x
	var left_x = x
	for y in range(_y + TILE_SIZE, _y + (left_depth * TILE_SIZE), TILE_SIZE):
		for _x in range(1, left_x):
			var block = CaveWall1.instance()
			block.position = Vector2((_x * TILE_SIZE) + LEFT_BOUND, y)
			$Tiles.add_child(block)
		left_x -= 1

	# Right side steps positive x
	var right_x = x
	for y in range(_y + TILE_SIZE, _y + (right_depth * TILE_SIZE), TILE_SIZE):
		for _x in range(right_x + opening, 15):
			var block = CaveWall1.instance()
			block.position = Vector2((_x * TILE_SIZE) + LEFT_BOUND, y)
			$Tiles.add_child(block)
		right_x += 1

func make_starting_chunk():
	var top_bound = 0
	var bottom_bound = 500

	for x in range(LEFT_BOUND, RIGHT_BOUND, TILE_SIZE):
		var world_top = CaveWall1.instance()
		world_top.position = Vector2(x, -70)
		
		var chunk_top = CaveWall1.instance()
		chunk_top.position = Vector2(x, 0)
		$Tiles.add_child(world_top)
		$Tiles.add_child(chunk_top)

	for y in range(top_bound, bottom_bound, TILE_SIZE):
		var left_wall = CaveWall1.instance()
		left_wall.position = Vector2(LEFT_BOUND, y)
		$Tiles.add_child(left_wall)
		
		var right_wall = CaveWall1.instance()
		right_wall.position = Vector2(RIGHT_BOUND, y)
		$Tiles.add_child(right_wall)

func make_final_chunk():
	var top_bound = 18500
	var bottom_bound = 20000
	
	for x in range(LEFT_BOUND - (TILE_SIZE * 5), LEFT_BOUND + TILE_SIZE, TILE_SIZE):
		var top_left = CaveWall1.instance()
		top_left.position = Vector2(x, top_bound)
		$Tiles.add_child(top_left)
		
	for x in range(RIGHT_BOUND, RIGHT_BOUND + (TILE_SIZE * 6), TILE_SIZE):
		var top_right = CaveWall1.instance()
		top_right.position = Vector2(x, top_bound)
		$Tiles.add_child(top_right)
	
	for y in range(top_bound, bottom_bound, TILE_SIZE):
		var left_wall = CaveWall1.instance()
		left_wall.position = Vector2(LEFT_BOUND - (TILE_SIZE * 6), y)
		$Tiles.add_child(left_wall)
		
		var right_wall = CaveWall1.instance()
		right_wall.position = Vector2(RIGHT_BOUND + (TILE_SIZE * 6), y)
		$Tiles.add_child(right_wall)
		
	for x in range(LEFT_BOUND - (TILE_SIZE * 6), RIGHT_BOUND + (TILE_SIZE * 6), TILE_SIZE):
		var bottom = CaveFloor.instance()
		bottom.position = Vector2(x, bottom_bound)
		$Tiles.add_child(bottom)
		
		var world_bottom = CaveWall1.instance()
		world_bottom.position = Vector2(x, bottom_bound + TILE_SIZE)
		$Tiles.add_child(world_bottom)
		
