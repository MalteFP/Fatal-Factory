extends Button

@export var building_scene: PackedScene
@export var texture: Texture2D


@onready var builder = get_parent().get_parent().get_parent().get_parent()

func _ready() -> void:
	icon = texture




func _on_pressed() -> void:
	builder.set_building(building_scene)
