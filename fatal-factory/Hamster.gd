extends Item
class_name Hamster

var movement_vector: Vector2 = Vector2(0,16)

var d: Array = [1, -1]

func _init() -> void:
	setup(
		load("res://textures/items/hamster/hamster.png"),
		6,
		"Hamster",
		"Found travling the world",
		load("res://textures/items/hamster/hamster_sprite_frames.tres")
		)

func _ready() -> void:
	movement_vector = movement_vector.rotated(randf_range(0,2 * PI))

func _process(delta: float) -> void:
	var future_position = global_position + movement_vector * delta * 5
	movement_vector = movement_vector.rotated(d.pick_random() * delta * 10)
	global_position = future_position
	if movement_vector.x < 0:
		scale.x = -1
	else:
		scale.x = 1
