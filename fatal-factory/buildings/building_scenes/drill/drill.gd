extends Building
var time_since_spawn: float = 0
var conveyor1: conveyor_curved

func _ready() -> void:
	z_index = 10
	setup(
		Vector2i(3,2),
		load("res://textures/buildings/drill/drill_sprite_frames.tres"),
		load("res://textures/buildings/drill/drill.png"),
		"Generates Per Secound: 7 Iron \n Costs: 90 wood \n Uses: 10 Watt",
		1,
		1
		)
	
	
	

func _process(delta: float) -> void:
	if placed:
		time_since_spawn += delta
		
		if time_since_spawn > 1:
			for item in conveyor1.items:
				if item.global_position.distance_to(to_global(Vector2(8,16))) < 8:
					sprite.pause()
					return
			sprite.play("default")
			time_since_spawn = 0
			var item = Item.new()
			item.setup(load("res://textures/items/temp_ore.png"), "Iron: Producded by drills")
			add_child(item)
			item.z_index = -1
			item.position = Vector2(8,16)
			WorldItemHolder.items_in_world.append(item)
		
	

func just_placed():
	conveyor1 = conveyor_curved.new()
	add_child(conveyor1)
	conveyor1.placed = true
	conveyor1.z_index = -10
	conveyor1.scale.x = -1
	conveyor1.rotation_degrees = 180
	conveyor1.position = Vector2(0,32)
	
	var conveyor2 = conveyor_curved.new()
	add_child(conveyor2)
	conveyor2.placed = true
	conveyor2.z_index = -10
	conveyor2.rotation_degrees = 90
	conveyor2.position = Vector2(32,16)
