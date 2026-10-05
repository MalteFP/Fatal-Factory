extends Item

class_name Raw_Gold

func _init() -> void:
	setup(
		load(
		"res://textures/items/ores/Raw_Gold.png"),
		2,
		"Raw Gold",
		"Produced by Drills  [img]res://textures/buildings/drill/drill.png[/img]"
		)
