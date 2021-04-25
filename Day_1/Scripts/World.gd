extends Node2D

var LevelChunk = preload("res://Environment/LevelChunk.tscn")
var num_chunks = 10
var RNG = RandomNumberGenerator.new()

const TILE_SIZE = 70
const LEFT_BOUND = -580
const RIGHT_BOUND = 490
const INNER_LEFT = LEFT_BOUND + TILE_SIZE
const INNER_RIGHT = RIGHT_BOUND - TILE_SIZE

func _ready():
	_make_level()
	
func _make_level():
	var offset = 0
	for _i in range(num_chunks):
		RNG.randomize()
		var chunk = LevelChunk.instance()
		chunk.make_chunk(offset)
		$LevelChunks.add_child(chunk)
		offset += 500
