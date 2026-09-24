extends Conveyor
class_name conveyor_straight
	

func _ready() -> void:
	setup(
		Vector2i(1,1),
		load("res://textures/buildings/conveyor/straight/conveyor_straight.tres"),
		load("res://textures/buildings/conveyor/straight/conveyor_straight.png"),
		"Transfers items",
		1,
		1
		)

func create_markers() -> void:
	goal_marker = Node2D.new()
	add_child(goal_marker)
	goal_marker.position = Vector2(8,16)
	
	start_marker = Node2D.new()
	add_child(start_marker)
	start_marker.position = Vector2(8,0)
