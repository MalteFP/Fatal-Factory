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

var last_item: Item

func _init() -> void:
	rotatable = true
	mirrorable = true
	set_transformations()
	create_markers()
	create_arrows()

func _process(delta: float) -> void:
	queue_redraw()
	for i in range(items.size() - 1, -1, -1):
		if not is_instance_valid(items[i]):
			items.remove_at(i)
	
	if placed:
		for item in items:
			for marker in goal_markers:
				if item.global_position.distance_to(marker.global_position) < 0.1:
					WorldItemHolder.items_in_world.append(item)
					last_item = item
					items.erase(item)
					continue
		for i in range(items.size()):
			for marker in goal_markers:
				var item = items[i]
				var next_pos = item.global_position.move_toward(marker.global_position, delta * speed * level)
				
				if i == 0:
					if not last_item or next_pos.distance_to(last_item.global_position) > 8:
						item.global_position = next_pos
				elif next_pos.distance_to(items[i - 1].global_position) > 8:
					item.global_position = next_pos
		
		for item in WorldItemHolder.items_in_world:
			for marker in start_markers:
				if item and item.global_position.distance_to(marker.global_position) <= 4:
					items.append(item)
					WorldItemHolder.items_in_world.erase(item)

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
