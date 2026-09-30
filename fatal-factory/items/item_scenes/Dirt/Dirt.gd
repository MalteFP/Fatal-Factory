extends Item

class_name Dirt

func _init() -> void:
	setup(
		load(
		"res://textures/items/ores/dirt.png"),
		4,
		"Dirt",
		"Produced by Drills  [img]res://textures/buildings/drill/drill.png[/img]"
		)
