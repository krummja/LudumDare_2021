extends Node2D

var LevelChunk = preload("res://Environment/LevelChunk.tscn")
var Angler = preload("res://Entities/Enemy_Angler.tscn")
onready var root = get_owner()
onready var entities = root.get_node("Entities")

var num_chunks = 36
var RNG = RandomNumberGenerator.new()
var player_position
var message
var StoryChunk = preload("res://Environment/StoryOverlay.tscn")

const TILE_SIZE = 70
const LEFT_BOUND = -580
const RIGHT_BOUND = 490
const INNER_LEFT = LEFT_BOUND + TILE_SIZE
const INNER_RIGHT = RIGHT_BOUND - TILE_SIZE
const FINAL_ROOM = 36 * 500


func _ready():
#	RNG.seed = hash("foo")
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
		
		var spawn_chance = RNG.randi_range(0, 100)
		if spawn_chance < 45:
			_spawn_fishy(offset)
		
		_add_story(_i+1)
		var story = StoryChunk.instance()
		story.position = Vector2(0, offset)
		story.get_node("StoryText").parse_bbcode("[center][pulse color=#000FFF height=0.0 freq=1.2]%s[/pulse][/center]" % message)
		$StoryChunks.add_child(story)
	
	offset += 500
	var final_chunk = LevelChunk.instance()	
	final_chunk.make_final_chunk()
	$LevelChunks.add_child(final_chunk)
	
func _spawn_fishy(_offset):
	var new_fishy = Angler.instance()
	var side = RNG.randi_range(0, 100)
	var x_pos = 0
	if side < 50:
		x_pos -= 200
	else:
		x_pos += 200
	new_fishy.position = Vector2(x_pos, _offset - 150)
	entities.add_child(new_fishy)
	new_fishy.owner = entities


func _add_story(chunkNum):
	match chunkNum:
		1:
			message = "You are clumsy like this."
		2:
			message = "Humans are always clumsy down here."
		3:
			message = "Nothing can prepare for how its weight plays against yours. \nHow you are lighter, and " \
					+ "yet pressed."
		4:
			message = "The water makes you feel surrounded."
		5:
			message = "Heavy on your shoulders, the helmet keeps you safe.\nThe water out, and the you inside;\n" \
					+ "an upside-down canoe taken to its logical conclusion.\nAn empty head overlaying your own."
		6:
			message = "Air is a liquid too, but kinder."
		7:
			message = "You have not come defenseless.\nThere is always something moving in the water.\n" \
					+ "There are fish.\nThere is silt.\nPlants."
		8:
			message = "Danger."
		9:
			message = "Your vision is barred by your own design.\nYour intention.\n" \
					+ "Things move past too quickly to see and you think, for the first time"
		10:
			message = "The Ocean is Older Than Us."
		11:
			message = "A slow breath."
		12:
			message = "The water rushes. Roars.\nYour heartbeat rushes. Roars.\nKindred.\n" \
					+ "So loud that there is no sound.\nYou are deafened."
		13:
			message = "While we were busy changing form;\nGrow, die, decay;\nThe water was always water."
		14:
			message = "It Is"
		15:
			message = "The claustrophobia is expected.\nBut the weight...\nNot of the water, but of the Water.\n" \
					+ "Formless, flowing, pressing, endless, ancient."
		16:
			message = "Do not let your breathing stutter.\nSlow in, slow out.\nFog the glass behind your " \
					+ "intentional bars.\nYou cannot wipe it clear."
		17:
			message = "There are things moving in the ocean.\nNo need to fear.\n" \
					+ "There are also things moving on land.\nAlso things--"
		18:
			message = "The Ocean Remembers."
		19:
			message = "The gloves make your hands\nclumsy.\nAll of you,\nclumsy."
		20:
			message = "It is normal for things to move in the water."
		21:
			message = "There should be more things\nmoving in the water."
		22:
			message = "Not only--"
		23:
			message = "Here, your foot kicks up sand\nwhich has known more \nthan you will ever learn."
		24:
			message = "It becomes heavy clouds\nin the ancient body\nyou wandered into."
		25:
			message = "Brave, they called you."
		26:
			message = "The Ocean is Hungry"
		27:
			message = "They are not your thoughts."
		28:
			message = "This is not-- "
		29:
			message = "Weight grinds every motion into pressure.\nFear grinds every pressure into active, "\
					+ "knowing resistance."
		30:
			message = "Into cruelty."
		31:
			message = "No,\n        (the sand kicked up by your boots makes ghosts of invisible currents)\n" \
					+ "No, the ocean,\n        (the flicker and whirl and turn of fish through the cage of your " \
					+ "empty head)\nThe ocean is not cruel."
		32:
			message = "No crueler than hunger,\n        (you feel surrounded)\nor age\n        (nothing can prepare.)"
		33:
			message = "There is a shadow in\n                             The ocean.\n    or"
		34:
			message = "The ocean is a shadow;\n                         A reflection’s sick twin.\n    or"
		35:
			message = "The shadow is on this world and on\n          You now."
		36:
			message = "She is Older Than You."
		37:
			message = "Clench your sweating hand as the churning silt you mistook for natural movement congeals into--"
		38:
			message = "She is-- "
		39:
			message = "a goddess, or a monster, or a demon, or the ocean, the ocean, the ocean"
		40:
			message = "She Remembers-- "
		41:
			message = "your limbless bodies, writhing in these waters when human was another word for worm."
		42:
			message = "She is Hungrier Than You."
		43:
			message = "The water makes you feel surrounded."
		_:
			message = ""
