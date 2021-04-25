extends Node2D

var LevelChunk = preload("res://Environment/LevelChunk.tscn")
var num_chunks = 36
var RNG = RandomNumberGenerator.new()
var player_position

const TILE_SIZE = 70
const LEFT_BOUND = -580
const RIGHT_BOUND = 490
const INNER_LEFT = LEFT_BOUND + TILE_SIZE
const INNER_RIGHT = RIGHT_BOUND - TILE_SIZE
const FINAL_ROOM = 36 * 500

func _ready():
	RNG.seed = hash("foo")
	RNG.randomize()
	_make_level()

func _make_level():
	var starting_chunk = LevelChunk.instance()
	starting_chunk.make_starting_chunk()
	$LevelChunks.add_child(starting_chunk)
	
	var offset = 500
	for _i in range(num_chunks):
		var chunk = LevelChunk.instance()
		chunk.make_chunk(offset, RNG)
		$LevelChunks.add_child(chunk)
		offset += 500

	var final_chunk = LevelChunk.instance()
	final_chunk.make_final_chunk()
	$LevelChunks.add_child(final_chunk)

	
