extends Building

var start_marker: Node2D
var start_marker_2: Node2D

func _ready() -> void:
	z_index = 10
	setup(
		Vector2i(4,4),
		load("res://textures/buildings/hub/hub_sprite_frames.tres"),
		"The place to store your stuff",
		1,
		1
		)

func _process(_delta: float) -> void:
	for item in WorldItemHolder.items_in_world:
		if item and (item.global_position.distance_to(start_marker.global_position) < 8 or item.global_position.distance_to(start_marker_2.global_position) < 8):
			WorldItemHolder.items_in_world.erase(item)
			item.queue_free()

func just_placed():
	var conveyor1 = conveyor_straight.new()
	add_child(conveyor1)
	conveyor1.placed = true
	conveyor1.z_index = -10
	conveyor1.rotation_degrees = 180
	conveyor1.position = Vector2(32,64)
	
	var conveyor2 = conveyor_straight.new()
	add_child(conveyor2)
	conveyor2.placed = true
	conveyor2.z_index = -10
	conveyor2.rotation_degrees = 180
	conveyor2.position = Vector2(48,64)
	
	start_marker = Node2D.new()
	start_marker.position = Vector2(24,48)
	add_child(start_marker)
	
	start_marker_2 = Node2D.new()
	start_marker_2.position = Vector2(40,48)
	add_child(start_marker_2)

func _draw() -> void:
	if start_marker:
		draw_circle(to_local(start_marker.global_position), 10, Color(1.0, 0.0, 0.0, 1.0), true)
