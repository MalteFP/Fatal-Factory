extends PanelContainer

@onready var title = $MarginContainer/VBoxContainer/Title/Label
@onready var icon = $MarginContainer/VBoxContainer/Title/Icon
@onready var discription = $MarginContainer/VBoxContainer/Discription
var parent: Building

func _ready() -> void:
	parent = get_parent()
	visible = true
	z_index = 10


func appear() -> void:
	visible = true
	rotation = -parent.global_rotation
	global_position = get_local_mouse_position() - Vector2(8,8)

func _process(delta: float) -> void:
	if not _is_mouse_in_bounds() and visible:
		visible = false


func _is_mouse_in_bounds() -> bool:
	return Rect2(Vector2.ZERO, size).has_point(get_local_mouse_position())
