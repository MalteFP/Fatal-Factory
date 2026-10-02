extends PanelContainer
@onready var title = $MarginContainer/VBoxContainer/Title/Label
@onready var icon = $MarginContainer/VBoxContainer/Title/TextureRect
@onready var discription = $MarginContainer/VBoxContainer/Discription
@onready var upgrade_button = $MarginContainer/VBoxContainer/Upgrade/Button
@onready var upgrade_cost = $MarginContainer/VBoxContainer/Upgrade/cost

func _ready() -> void:
	visible = false
	rotation = -get_parent().global_rotation
	


func _on_mouse_exited() -> void:
	await get_tree().process_frame
	if _is_mouse_inside():
		return
	rotation = -get_parent().global_rotation
	visible = false


func appear() -> void:
	visible = true
	global_position = get_global_mouse_position() + Vector2(-16,-16)

func _is_mouse_inside() ->bool:
	var local_mouse = get_local_mouse_position()
	return Rect2(Vector2.ZERO, size).has_point(local_mouse)
		
		
		
		
		
		
		
		
		
