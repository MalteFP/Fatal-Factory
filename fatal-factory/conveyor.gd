extends Building
class_name Conveyor

var items: Array[Item] = []

var goal_marker: Node2D
var goal_arrow: Sprite2D

var start_marker: Node2D
var start_arrow: Sprite2D

var speed: float = 10

var last_item: Item

func _init() -> void:
	rotatable = true
	mirrorable = true
	create_markers()
	create_arrows()

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
			if item and item.global_position.distance_to(start_marker.global_position) < 8:
				items.append(item)
				WorldItemHolder.items_in_world.erase(item)
	queue_redraw()

func create_markers() -> void:
	pass

func create_arrows() ->void:
	start_arrow = Sprite2D.new()
	start_arrow.texture = load("res://textures/buildings/conveyor/arrow.png")
	start_arrow.self_modulate = Color(0.0, 1.0, 0.0, 1.0)
	add_child(start_arrow)
	start_arrow.position = start_marker.position
	start_arrow.rotation_degrees = 180
	
	goal_arrow = Sprite2D.new()
	goal_arrow.texture = load("res://textures/buildings/conveyor/arrow.png")
	goal_arrow.self_modulate = Color(1.0, 0.0, 0.0, 1.0)
	add_child(goal_arrow)
	goal_arrow.position = goal_marker.position
	goal_arrow.rotation_degrees = 180


func just_placed():
	placed = true
	start_arrow.visible = false
	goal_arrow.visible = false
	
