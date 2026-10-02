extends Building
var time_since_spawn: float = 0
var time_for_spawn: float
var conveyor1: Conveyor_curved
var spawn_per_minute: int
var secounds_per_spawn: float


var production_class

var ore_type_tresholds: Array[Dictionary] = [
	{"max distance": 100, "ore": Raw_Iron},
	{"max distance": 500, "ore": Raw_Gold},
	{"max distance": 1000, "ore": Raw_Beryllium},
	{"max distance": 10000000, "ore": Raw_Uranium}
]
@export var production_item: PackedScene

func _ready() -> void:
	
	spawn_per_minute = 20
	secounds_per_spawn = 60 / spawn_per_minute
	
	
	
	z_index = 10
	setup(
		"Drill",
		Vector2i(3,2),
		load("res://textures/buildings/drill/drill_sprite_frames.tres"),
		load("res://textures/buildings/drill/drill.png"),
		"Generates Per Secound: 7 Iron \n Costs: 90 wood \n Uses: 1 Energy pr. ore",
		[ 
			[15,Dirt.new()]
			],
		[
			[spawn_per_minute, Raw_Iron.new()]
			]
		)
	
	
	

func _process(delta: float) -> void:
	if not placed:
		return
	time_since_spawn += delta
	
	
	if time_since_spawn > secounds_per_spawn / level:
		for item in conveyor1.items:
			if item and item.global_position.distance_to(to_global(Vector2(8,16))) < 8 or Inventory.items[5] < 1:
				sprite.pause()
				return
		sprite.play("default")
		time_since_spawn = 0
		Inventory.item_collected(Energy.new(),-1)
		var item = production_class.new()
		add_child(item)
		item.z_index = -1
		item.position = Vector2(8,16)
		WorldItemHolder.items_in_world.append(item)
		
		
		
		

func just_placed_building_special():
	conveyor1 = Conveyor_curved.new()
	conveyor1.partial_building = true
	add_child(conveyor1)
	conveyor1.placed = true
	conveyor1.z_index = -10
	conveyor1.scale.x = -1
	conveyor1.rotation_degrees = 180
	conveyor1.position = Vector2(0,32)
	
	var conveyor2 = Conveyor_curved.new()
	conveyor2.partial_building = true
	add_child(conveyor2)
	conveyor2.placed = true
	conveyor2.z_index = -10
	conveyor2.rotation_degrees = 90
	conveyor2.position = Vector2(32,16)
	
	conveyor1.just_placed()
	conveyor2.just_placed()
	
	child_buildings.append(conveyor1)
	child_buildings.append(conveyor2)
	
	var world = get_tree().get_first_node_in_group("world")
	if(world.ore_noise_map.get_noise_2d(global_position.x / 16 + 2, global_position.y / 16 + 1) + 1)/2 > 0.2:
		production_class = Dirt
	else:
		for ore in ore_type_tresholds:
			if global_position.distance_to(Vector2(0,0)) < ore["max distance"] * 16:
				production_class = ore["ore"]
				break
