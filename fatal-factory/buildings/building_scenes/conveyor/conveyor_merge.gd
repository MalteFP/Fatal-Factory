extends Conveyor
class_name conveyor_merge
	
var start_markers
func _ready() -> void:
	setup(
		Vector2i(1,1),
		load("res://textures/buildings/conveyor/Merge/x-conveyor.tres"),
		load("res://textures/buildings/conveyor/Merge/x-conveyor.png"),
		"Transfers items",
		[
			[5,Raw_Iron.new()]
			]
		)
	goal_arrow.rotation_degrees = 180
	start_arrow.rotation_degrees = 180
	

func create_markers() -> void:
	goal_marker = Node2D.new()
	add_child(goal_marker)
	goal_marker.position = Vector2(8,12)
	
	start_marker = Node2D.new()
	add_child(start_marker)
	start_marker.position = Vector2(8,0)
	
	
	var start_marker1 = Node2D.new()
	add_child(start_marker1)
	start_marker1.position = Vector2(0,8)
	var start_marker2 = Node2D.new()
	add_child(start_marker2)
	start_marker2.position = Vector2(16,8)
	var start_marker3 = Node2D.new()
	add_child(start_marker3)
	start_marker3.position = Vector2(8,0)
	start_markers = [start_marker1,start_marker2,start_marker3]
func _process(delta: float) -> void:
	for i in range(items.size() - 1, -1, -1):
		if not is_instance_valid(items[i]):
			items.remove_at(i)
	
	if placed:
		for item in items:
			if item.global_position.distance_to(goal_marker.global_position) < 0.1:
				WorldItemHolder.items_in_world.append(item)
				last_item = item
				items.erase(item)
				continue
		for i in range(items.size()):
			var item = items[i]
			var next_pos = item.global_position.move_toward(goal_marker.global_position, delta * speed)
			
			if i == 0:
				if not last_item or next_pos.distance_to(last_item.global_position) > 8:
					item.global_position = next_pos
			elif next_pos.distance_to(items[i - 1].global_position) > 8:
				item.global_position = next_pos
		
		for item in WorldItemHolder.items_in_world:
			for marker in start_markers:
				if item and item.global_position.distance_to(start_markers[marker].global_position) <= 4:
					items.append(item)
					WorldItemHolder.items_in_world.erase(item)
	queue_redraw()
