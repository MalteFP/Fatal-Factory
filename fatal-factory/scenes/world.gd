extends Node2D




var noise_map = FastNoiseLite.new()
var ore_noise_map = FastNoiseLite.new()
var biome_noise_map = FastNoiseLite.new()

@onready var tilemap = $TileMapLayer
@onready var ore_tilemap = $OreTileMapLayer
@onready var camera = $Camera2D

var generated_tiles: Dictionary = {}

var frequency = 0.005
var ore_frequency = 0.03
var biome_frequency = 0.005

var rotations: Array = [
	0,
	TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V
]

var thresholds: Array[Dictionary] = [
	{"limit": 0.2, "tile": Vector2i(0,0)},
	{"limit": 0.67, "tile": Vector2i(1,0)},
	{"limit": 0.7, "tile": Vector2i(5,0)},
	{"limit": 0.75, "tile": Vector2i(6,0)},
	{"limit": 1, "tile": Vector2i(7,0)}
]

var ore_thresholds: Array[Dictionary] = [
	{"limit": 0.2, "tile": Vector2i(4,0)},
]

var ore_type_tresholds: Array[Dictionary] = [
	{"max distance": 100, "tile": Vector2i(0,0)},
	{"max distance": 500, "tile": Vector2i(1,0)},
	{"max distance": 1000, "tile": Vector2i(2,0)},
	{"max distance": 10000000, "tile": Vector2i(3,0)}
]

var biome_grass_tresholds: Array[Dictionary] = [
	{"limit": 0.33, "tile": Vector2i(1,0)},
	{"limit": 0.8, "tile": Vector2i(2,0)},
	{"limit": 1, "tile": Vector2i(3,0)},
]

func _process(_delta: float) -> void:
	generate_visible_tiles()

func _ready() -> void:
	var item = Raw_Iron.new()
	Inventory.item_collected(item, 50)
	item = Raw_Uranium.new()
	Inventory.item_collected(item, 500)
	item = Energy.new()
	Inventory.item_collected(item, 50)
	
	var hub = Hub.new()
	add_child(hub)
	hub.just_placed()
	
	
	noise_map.seed = randi()
	noise_map.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise_map.frequency = frequency
	noise_map.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise_map.fractal_octaves = 2.5
	
	
	ore_noise_map.seed = randi()
	ore_noise_map.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	ore_noise_map.frequency = ore_frequency
	ore_noise_map.fractal_type = FastNoiseLite.FRACTAL_FBM
	ore_noise_map.fractal_octaves = 2
	
	biome_noise_map.seed = randi()
	biome_noise_map.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	biome_noise_map.frequency = biome_frequency
	biome_noise_map.fractal_type = FastNoiseLite.FRACTAL_FBM
	biome_noise_map.fractal_octaves = 1


func get_tile_type(noise_value: float, ore_noise_value: float, biome_noise_value: float, coords: Vector2) -> Vector2i:
	for treshold in ore_thresholds:
		if ore_noise_value < treshold["limit"]:
			place_ore(coords)
			return treshold["tile"]
	for treshold in thresholds:
		if noise_value < treshold["limit"]:
			if treshold["tile"] == Vector2i(1,0):
				for biome_treshold in biome_grass_tresholds:
					if biome_noise_value < biome_treshold["limit"]:
						return biome_treshold["tile"]
			return treshold["tile"]
	return Vector2i(7,0)
#Lundses was here

func generate_visible_tiles():
	var viewport_size = get_viewport_rect().size * (Vector2(1,1) / camera.zoom) 
	var camera_pos = camera.global_position
	
	
	var top_left = camera_pos - viewport_size / 2
	var bottom_right = camera_pos + viewport_size / 2
	
	
	var start_x = floor(top_left.x / 16.0)
	var end_x = ceil(bottom_right.x / 16.0)
	
	var start_y = floor(top_left.y / 16.0)
	var end_y = ceil(bottom_right.y / 16.0)
	
	
	for x in range(start_x, end_x + 1):
		for y in range(start_y, end_y + 1):
			var pos = Vector2i(x,y)
			
			if generated_tiles.has(pos):
				continue
			
			generated_tiles[pos] = true
			
			var noise_value = (noise_map.get_noise_2d(x, y) + 1)/2
			var ore_noise_value = (ore_noise_map.get_noise_2d(x, y) + 1)/2
			var biome_noise_value = (biome_noise_map.get_noise_2d(x,y) + 1)/2
			var atlas_coords: Vector2i = get_tile_type(noise_value, ore_noise_value, biome_noise_value, Vector2(x,y))
			tilemap.set_cell(
				Vector2i(x, y),
				0,
				atlas_coords,
				rotations.pick_random()
				)
	
	
func place_ore(coords: Vector2):
	var distance = Vector2(0,0).distance_to(coords)
	for treshold in ore_type_tresholds:
		if distance < treshold["max distance"]:
			if randi_range(0,4) == 0:
				ore_tilemap.set_cell(
					coords,
					0,
					treshold["tile"],
					rotations.pick_random()
					)
			return
