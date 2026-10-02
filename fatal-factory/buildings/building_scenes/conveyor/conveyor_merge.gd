extends Conveyor
class_name Conveyor_merge

func _ready() -> void:
	setup(
		"Merge Conveyor",
		Vector2i(1,1),
		load("res://textures/buildings/conveyor/Merge/x-conveyor.tres"),
		load("res://textures/buildings/conveyor/Merge/x-conveyor.png"),
		"Transfers items",
		[
			[5,Raw_Iron.new()]
			]
		)

func set_transformations() -> void:
	start_marker_transformations = [
	Transform2D(deg_to_rad(180), Vector2(8,0)),
	Transform2D(deg_to_rad(90), Vector2(0,8)),
	Transform2D(deg_to_rad(270), Vector2(16,8)),
	]

	goal_marker_transformations = [
	Transform2D(deg_to_rad(180), Vector2(8,16))
	]
