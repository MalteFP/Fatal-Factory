extends Item

class_name Iron

func _init() -> void:
	setup(
		load(
		"res://textures/items/temp_ore.png"),
		0,
		"Iron",
		"Produced by Drills  [img]res://textures/buildings/drill/drill.png[/img]"
		)
