extends TileMap

var map_width = 10
var map_height = 20

# Tile constants
const TILE_DIRT = 100
const TILE_GRASS = 101

# 2D Matrix for the map (manually define tiles)
var map_matrix : Array = []

func _ready():
	# Initialize the map matrix with your tile types
	initialize_map()
	
	# Generate the map based on the matrix
	generate()

func _process(delta: float) -> void:
	var tile = local_to_map(get_global_mouse_position())
	print(tile)
	if Input.is_action_pressed("leftClick"):
		set_cell(0, tile, 100, Vector2i(0,0), 0)
	if Input.is_action_pressed("rightClick"):
		erase_cell(0, tile)
		

func initialize_map():
	map_matrix = []
	for i in range(map_height):
		var row = []
		for j in range(map_width):
			row.append(TILE_GRASS)
		map_matrix.append(row)

func generate():

	for x in range(map_width):
		for y in range(map_height):
			var tile_type = map_matrix[y][x]
			set_cell(0, Vector2(x, y), tile_type, Vector2i(0,0), 0)
