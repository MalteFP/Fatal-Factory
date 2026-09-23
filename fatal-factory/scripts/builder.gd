extends Node2D

var cell_size = 16

var building_size: Vector2i = Vector2i(3,5)

var rect_pos: Vector2

var deleting: bool = false

var currently_building: Building

var buildings = []

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	rect_pos = cell_to_world(get_mouse_cell())
	if currently_building and not deleting:
		currently_building.global_position = rect_pos
	elif deleting:
		$DeletionMask/CollisionShape2D.global_position = rect_pos + Vector2(8,8)

func get_mouse_cell() -> Vector2i:
	var mouse = get_global_mouse_position()
	
	return Vector2i(
		floori(mouse.x / cell_size),
		floori(mouse.y / cell_size)
	)

func cell_to_world(cell: Vector2i) -> Vector2:
	return cell * cell_size

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		if deleting:
			delete()
		else:
			build()
	if Input.is_action_just_pressed("build"):
		deleting = false
		$DeletionMask/CollisionShape2D/Polygon2D.visible = false
		$DeletionMask/CollisionShape2D.disabled = true
	if Input.is_action_just_pressed("delete"):
		deleting = true
		$DeletionMask/CollisionShape2D/Polygon2D.visible = true
		$DeletionMask/CollisionShape2D.disabled = false
	
func set_building(building_scene: PackedScene):
	if currently_building:
		queue_free()
	currently_building = building_scene.instantiate()
	add_child(currently_building)




func is_overlapping(area: Area2D) -> bool:
	return area.has_overlapping_areas()


func build():
	if currently_building and not is_overlapping(currently_building.area):
			currently_building = null
	elif currently_building:
		var blinkTween = get_tree().create_tween()
		blinkTween.tween_property(
			currently_building.sprite,
			"self_modulate",
			Color(1.0, 0.0, 0.0, 1.0),
			0.1
			)
		blinkTween.chain().tween_property(
			currently_building.sprite,
			"self_modulate",
			Color(1.0, 1.0, 1.0, 1.0),
			0.1)


func delete():
	var overlap = $DeletionMask.get_overlapping_areas()
	for area in overlap:
		area.get_parent().queue_free()
