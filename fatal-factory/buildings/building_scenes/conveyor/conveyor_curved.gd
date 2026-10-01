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
	goal_arrow.rotation_degrees = 90
	start_arrow.rotation_degrees += 180
	start_arrow.position += Vector2(0,8)

func create_markers() -> void:
	goal_marker = Node2D.new()
	add_child(goal_marker)
	goal_marker.position = Vector2(16,8)
	
	start_marker = Node2D.new()
	add_child(start_marker)
	start_marker.position = Vector2(8,16)
