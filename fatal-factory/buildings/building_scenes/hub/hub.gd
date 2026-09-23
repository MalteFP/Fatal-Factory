extends Building

func _ready() -> void:
	z_index = 10
	setup(
		Vector2i(5,4),
		load("res://textures/buildings/hub/hub_sprite_frames.tres"),
		"The place to store your stuff",
		1,
		1
		)
