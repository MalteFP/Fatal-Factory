extends Item

class_name Raw_Uranium

func _init() -> void:
	setup(
		load(
		"res://textures/items/ores/Raw_Uranium.png"),
		3,
		"Raw Uranium",
		"Produced by Drills  [img]res://textures/buildings/drill/drill.png[/img]"
		)
