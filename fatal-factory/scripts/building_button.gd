extends Button

@export var building_scene: PackedScene
@onready var builder = get_parent().get_parent().get_parent().get_parent()

var building_name: String

func _ready() -> void:
	var temp = building_scene.instantiate()
	add_child(temp)
	building_name = temp.name
	icon = temp.icon
	tooltip_text = temp.tooltip
	temp.queue_free()





func _on_pressed() -> void:
	builder.deleting = false
	builder.set_building(building_scene)


func _make_custom_tooltip(_for_text):
	var l = load("res://builder_tooltip.tscn")
	var label = l.instantiate()
	label.setup(
		building_name, 
		icon,
		"""Cost: 10 Iron [img]res://textures/items/temp_ore.png[/img] """)
	return label
	
	
	
	
	
	
	
	
