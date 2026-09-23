extends Building


func _ready() -> void:
	setup(
		Vector2i(1,1),
		load("res://textures/buildings/conveyor/straight/conveyor_straight.tres"),
		"Transfers items",
		1,
		1
		)
