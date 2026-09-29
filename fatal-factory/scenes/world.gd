extends Node2D

var noise_map = FastNoiseLite.new()

@onready var tilemap = $TileMapLayer

var frequency = 0.01

var size = Vector2(100,100)

var rotations: Array = [
	0,
	TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V
]

var thresholds: Array[Dictionary] = [
	{"limit": 0.2, "tile": Vector2i(0,0)},
	{"limit": 0.4, "tile": Vector2i(2,0)},
	{"limit": 0.5, "tile": Vector2i(5,0)},
	{"limit": 0.6, "tile": Vector2i(6,0)},
	{"limit": 1, "tile": Vector2i(7,0)}
]

func _ready() -> void:
	var item = Iron.new()
	Inventory.item_collected(item, 50)
	
	var hub = Hub.new()
	add_child(hub)
	hub.just_placed()
	
	
	noise_map.seed = randi()
	noise_map.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise_map.frequency = frequency
	
	for x in range(size.x):
		for y in range(size.y):
			var noise_value = (noise_map.get_noise_2d(x, y) + 1)/2
			var atlas_coords: Vector2i = get_tile_type(noise_value)
			
			tilemap.set_cell(
				Vector2i(x, y) - Vector2i(size) / 2,
				0,
				atlas_coords,
				rotations.pick_random()
				)

func get_tile_type(noise_value: float) -> Vector2i:
	for treshold in thresholds:
		if noise_value < treshold["limit"]:
			return treshold["tile"]
	return Vector2i(7,0)
