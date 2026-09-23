extends Building
class_name Conveyor

var items: Array[Item] = []

var goal_marker: Node2D

var start_marker: Node2D

var speed: float = 10

var last_item: Item

func _init() -> void:
	rotatable = true
	mirrorable = true
	create_markers()

func _process(delta: float) -> void:
	for i in range(items.size() - 1, -1, -1):
		if not is_instance_valid(items[i]):
			items.remove_at(i)
	
	if placed:
		for item in items:
			if item.global_position == goal_marker.global_position:
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
			if item and item.global_position.distance_to(start_marker.global_position) < 8:
				items.append(item)
				WorldItemHolder.items_in_world.erase(item)
	queue_redraw()

func create_markers() -> void:
	pass
	
	
	
func _draw() -> void:
	if goal_marker:
		draw_circle(to_local(goal_marker.global_position), 1, Color(0.0, 0.0, 1.0, 1.0))
		draw_circle(to_local(start_marker.global_position), 1, Color(1.0, 0.0, 0.0, 1.0))
		

func delete():
	for item in items:
		item.queue_free()
	queue_free()
