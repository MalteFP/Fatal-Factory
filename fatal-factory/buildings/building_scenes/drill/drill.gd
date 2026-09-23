extends Building


func _ready() -> void:
	setup(
		Vector2i(3,2),
		load("res://textures/buildings/drill/drill_sprite_frames.tres"),
		"Generates Per Secound: 7 Iron \n Costs: 90 wood \n Uses: 10 Watt",
		1,
		1
		)
