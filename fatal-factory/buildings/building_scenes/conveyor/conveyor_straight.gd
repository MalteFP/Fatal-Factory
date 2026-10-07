extends Conveyor
class_name Conveyor_straight
	
func _ready() -> void:
	setup(
		"Straight Conveyor",
		Vector2i(1,1),
		load("res://textures/buildings/conveyor/dirt_conveyor/straight/conveyor_straight.tres"),
		load("res://textures/buildings/conveyor/dirt_conveyor/straight/conveyor_straight.png"),
		"Transfers items",
		[
			[5,Dirt.new()]
			]
		)

func set_transformations() -> void:
	start_marker_transformations = [
	Transform2D(deg_to_rad(180), Vector2(8,0)),
	]

	goal_marker_transformations = [
	Transform2D(deg_to_rad(180), Vector2(8,16))
	]
