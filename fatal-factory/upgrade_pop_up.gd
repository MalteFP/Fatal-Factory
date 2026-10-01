extends PanelContainer

@onready var title = $MarginContainer/VBoxContainer/Title/Label
@onready var icon = $MarginContainer/VBoxContainer/Title/Icon
@onready var discription = $MarginContainer/VBoxContainer/Discription
var parent: Building

func _ready() -> void:
	parent = get_parent()
	visible = false
	z_index = 100
	
	title.text = parent.name
	icon.texture = parent.icon
	discription.text = parent.tooltip


func appear() -> void:
	visible = true
	rotation = -parent.global_rotation
	global_position = get_local_mouse_position() - Vector2(8,8)

func _process(_delta: float) -> void:
	if not _is_mouse_in_bounds() and visible:
		visible = false


func _is_mouse_in_bounds() -> bool:
	return Rect2(Vector2.ZERO, size).has_point(get_local_mouse_position())



func _on_button_pressed() -> void:
	parent.level_up()
