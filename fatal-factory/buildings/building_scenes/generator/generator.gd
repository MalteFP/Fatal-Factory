extends Building
var time_since_spawn: float = 0
var time_for_spawn: float
var spawn_per_minute: int
var secounds_per_spawn: float

@export var production_item: PackedScene

func _ready() -> void:
	
	
	
	spawn_per_minute = 50
	secounds_per_spawn = 60 / spawn_per_minute
	
	
	z_index = 10
	setup(
		"Generator",
		Vector2i(3,3),
		load("res://textures/buildings/generator/generator_sprite_frames.tres"),
		load("res://textures/buildings/generator/Generator Passive.png"),
		"Geeenerates Per Secound: 50 Watts \n Costs: 15 Iron \n Uses: 1 Animal",
		[
			[15,Raw_Iron.new()],
			[1, Hamster.new()]
			],
		[
			[spawn_per_minute, Energy.new()]
			]
		)
	
	
	

func _process(delta: float) -> void:
	if placed:
		time_since_spawn += delta
		if time_since_spawn > secounds_per_spawn / level:
			Inventory.item_collected(Energy.new(),1)
			time_since_spawn = 0
		
		
		
	
