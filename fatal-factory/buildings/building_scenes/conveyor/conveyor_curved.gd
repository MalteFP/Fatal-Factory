extends Conveyor
class_name Conveyor_curved

func _ready() -> void:
	setup(
		"Curved Conveyor",
		Vector2i(1,1),
		load("res://textures/buildings/conveyor/curved/conveyor_curved.tres"),
		load("res://textures/buildings/conveyor/curved/conveyor_curved.png"),
		"Transfers items",
		[
			[5,Dirt.new()]
			]
		)

func set_transformations() -> void:
	start_marker_transformations = [
	Transform2D(deg_to_rad(0), Vector2(8,16))
	]

	goal_marker_transformations = [
	Transform2D(deg_to_rad(90), Vector2(16,8))
	]
