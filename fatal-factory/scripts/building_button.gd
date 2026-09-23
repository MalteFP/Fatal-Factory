extends Button

@export var building_scene: PackedScene
@onready var builder = get_parent().get_parent().get_parent().get_parent()

func _ready() -> void:
	var temp = building_scene.instantiate()
	add_child(temp)
	icon = temp.texture
	tooltip_text = temp.tooltip
	temp.queue_free()





func _on_pressed() -> void:
	builder.set_building(building_scene)


func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = for_text
	return label
	
