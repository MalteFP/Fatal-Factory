extends Node2D

var cell_size = 16

var building_size: Vector2i = Vector2i(3,5)

var rect_pos: Vector2

var currently_building: Building

func _process(_delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	rect_pos = snap_vector(mouse_pos, cell_size)
	if currently_building:
		currently_building.global_position = rect_pos - Vector2(currently_building.size * 8)

func snap_vector(vector: Vector2, step: Variant):
	return Vector2(snapped(vector.x, step), snapped(vector.y, step))


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		if currently_building and not is_overlapping(currently_building.get_node("Area2D")):
			currently_building = null
		elif currently_building:
			var blinkTween = get_tree().create_tween()
			blinkTween.tween_property(
				currently_building.get_node("BuildingSprite"),
				"self_modulate",
				Color(1.0, 0.0, 0.0, 1.0),
				0.1
				)
			blinkTween.chain().tween_property(
				currently_building.get_node("BuildingSprite"),
				"self_modulate",
				Color(1.0, 1.0, 1.0, 1.0),
				0.1)
	if Input.is_action_just_pressed("new building"):
		set_building()
	
	
func set_building():
	var b = preload("res://Building.tscn")
	currently_building = b.instantiate()
	currently_building.setup(Vector2i(2,4),load("res://textures/buildings/temp.png"),1,1)
	add_child(currently_building)



func is_overlapping(area: Area2D) -> bool:
	return area.has_overlapping_areas()
