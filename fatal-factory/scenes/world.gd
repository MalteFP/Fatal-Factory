extends Node2D

var noise_map = FastNoiseLite.new()

@onready var tilemap = $TileMapLayer

var frequency = 0.1

var size = Vector2(100,100)

func _ready() -> void:
	var item = Iron.new()
	Inventory.item_collected(item, 50)
	
	var hub = Hub.new()
	add_child(hub)
	hub.just_placed()
	
	
	noise_map.seed = randi()
	noise_map.noise_type = FastNoiseLite.TYPE_VALUE
	noise_map.frequency = frequency
	
	for x in range(size.x):
		for y in range(size.y):
			var noise_value = (noise_map.get_noise_2d(x, y) + 1)/2
			var atlas_coords: Vector2i = get_tile_type(noise_value)
			
			tilemap.set_cell(Vector2i(x, y) - Vector2i(size) / 2, 0, atlas_coords)
			
	
	

func get_tile_type(noise_value: float) -> Vector2i:
	if noise_value > 0.9:
		return Vector2i(0,0)
	elif noise_value > 0.4:
		return Vector2i(1,0)
	elif noise_value > 0.2:
		return Vector2i(2,0)
	else:
		return Vector2i(3,0)
