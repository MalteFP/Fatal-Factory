extends Conveyor
class_name Conveyor_iron_straight
	
func _ready() -> void:
	setup(
		"Straight Iron Conveyor",
		Vector2i(1,3),
		load("res://textures/buildings/conveyor/iron_conveyor/iron_conveyor.tres"),
		load("res://textures/buildings/conveyor/iron_conveyor/iron_conveyor.png"),
		"Transfers longer distances items",
		[
			[15,Raw_Iron.new()]
			]
		)
	speed = 200

func set_transformations() -> void:
	start_marker_transformations = [
	Transform2D(deg_to_rad(180), Vector2(8,0)),
	]

	goal_marker_transformations = [
	Transform2D(deg_to_rad(180), Vector2(8,48))
	]
