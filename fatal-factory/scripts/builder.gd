extends Node2D

var cell_size = 16

var building_size: Vector2i = Vector2i(3,5)

var rect_pos: Vector2

var deleting: bool = false

var currently_building: Building

var buildings = []

var rotationToVecDic = {0.0: Vector2i(0,0), 90.0: Vector2i(-1,0), 180.0: Vector2i(-1,-1), 270.0: Vector2i(0,-1)}

func _ready() -> void:
	deleting = false
	$DeletionMask/CollisionShape2D/Polygon2D.visible = false
	$DeletionMask/CollisionShape2D.disabled = true


func _process(_delta: float) -> void:
	rect_pos = cell_to_world(get_mouse_cell())
	if currently_building and not deleting:
		if currently_building.scale.x == -1:
			currently_building.global_position = rect_pos - Vector2(floor(currently_building.size.x / 2), floor(currently_building.size.y / 2)) * 16 - Vector2(currently_building.size * rotationToVecDic[wrapf(currently_building.rotation_degrees + 180, 0 ,360)] * 16)
			currently_building.move_local_y(-16)
		else:
			currently_building.global_position = rect_pos - Vector2(floor(currently_building.size.x / 2), floor(currently_building.size.y / 2)) * 16 - Vector2(currently_building.size * rotationToVecDic[currently_building.rotation_degrees] * 16)
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
	if not deleting and Input.is_action_just_pressed("rotate") and currently_building and currently_building.rotatable:
		currently_building.rotation_degrees = wrapf(currently_building.rotation_degrees + 90, 0 ,360)
	if not deleting and Input.is_action_just_pressed("mirror") and currently_building and currently_building.mirrorable:
		currently_building.scale.x *= -1
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
		currently_building.queue_free()
	currently_building = building_scene.instantiate()
	add_child(currently_building)




func is_overlapping(area: Area2D) -> bool:
	return area.has_overlapping_areas()


func build():
	if currently_building and not is_overlapping(currently_building.area):
		if Input.is_action_pressed("multi place"):
			var new_building = currently_building.duplicate()
			add_child(new_building)
			new_building.just_placed()
			new_building.placed = true
		else:
			currently_building.just_placed()
			currently_building.placed = true
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
		area.get_parent().delete()
