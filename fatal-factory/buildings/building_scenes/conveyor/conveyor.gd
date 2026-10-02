extends Building
class_name Conveyor

var start_marker_transformations: Array[Transform2D]
var goal_marker_transformations: Array[Transform2D]

var items: Array[Item] = []

var start_markers: Array[Node2D]
var goal_markers: Array[Node2D]

var start_arrow: Array[Sprite2D]
var goal_arrow: Array[Sprite2D]

var speed: float = 100

var spacing: float = 8

var last_item: Item

func _init() -> void:
	rotatable = true
	mirrorable = true
	set_transformations()
	create_markers()
	create_arrows()

func _process(delta: float) -> void:
	for i in range(items.size() - 1, -1, -1):
		if not is_instance_valid(items[i]):
			items.remove_at(i)
	if not placed:
		return
	if not is_instance_valid(last_item):
		last_item = null
		
	items.sort_custom(func(a, b): return _distance_to_goal(a) < _distance_to_goal(b))

	for i in range(items.size()):
		var item: Item = items[i]
		var goal = item.goal
		
		var next_pos = item.global_position.move_toward(goal.global_position, delta * speed * level)
		
		var blocker: Item = items[i - 1] if i > 0 else last_item
		
		if blocker == null or next_pos.distance_to(blocker.global_position) > spacing:
			item.global_position = next_pos
		
	if not items.is_empty():
		var front: Item = items[0]
		if _distance_to_goal(front) < 0.1:
			WorldItemHolder.items_in_world.append(front)
			last_item = front
			items.remove_at(0)
	
	for i in range(WorldItemHolder.items_in_world.size() -1, -1, -1):
		var item = WorldItemHolder.items_in_world[i]
		if not is_instance_valid(item):
			WorldItemHolder.items_in_world.remove_at(i)
			continue
		for marker in start_markers:
			if item.global_position.distance_to(marker.global_position) <= 4 and _has_space_for_new_item(item):
				item.goal = goal_markers[0]
				items.append(item)
				WorldItemHolder.items_in_world.remove_at(i)
				break


func _has_space_for_new_item(new_item: Item) -> bool:
	for other in items:
		if other.global_position.distance_to(new_item.global_position) < spacing:
			return false
	return true


func _distance_to_goal(item: Item) -> float:
	return item.global_position.distance_to(item.goal.global_position)

func create_markers() -> void:
	for transformation in goal_marker_transformations:
		var marker = Node2D.new()
		marker.transform = transformation
		add_child(marker)
		goal_markers.append(marker)
	
	for transformation in start_marker_transformations:
		var marker = Node2D.new()
		marker.transform = transformation
		add_child(marker)
		start_markers.append(marker)

func create_arrows() ->void:
	for marker in start_markers:
		var arrow = Sprite2D.new()
		arrow.texture = load("res://textures/buildings/conveyor/arrow.png")
		arrow.self_modulate = Color(0.0, 1.0, 0.0, 1.0)
		add_child(arrow)
		arrow.position = marker.position
		arrow.global_rotation = marker.global_rotation 
		arrow.move_local_y(8)
		arrow.z_index = 10
		start_arrow.append(arrow)
		
	for marker in goal_markers:
		var arrow = Sprite2D.new()
		arrow.texture = load("res://textures/buildings/conveyor/arrow.png")
		arrow.self_modulate = Color(1.0, 0.0, 0.0, 1.0)
		add_child(arrow)
		arrow.position = marker.position
		arrow.global_rotation = marker.global_rotation
		arrow.z_index = 10
		goal_arrow.append(arrow)
		
	
func delete():
	for c in cost:
		Inventory.item_collected(c[1], c[0])
	for item in items:
		Inventory.item_collected(item, 1)
		item.queue_free()
	queue_free()

func just_placed_building_special():
	for arrow in start_arrow:
		arrow.visible = false
	for arrow in goal_arrow:
		arrow.visible = false

func _draw() -> void:
	for marker in start_markers:
		draw_circle(marker.position, 1, Color.GREEN, true)
	for marker in goal_markers:
		draw_circle(marker.position, 1, Color.RED, true)



func set_transformations() -> void:
	pass
