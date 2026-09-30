extends Item
#Lundses was here
class_name Raw_Iron

func _init() -> void:
	setup(
		load(
		"res://textures/items/ores/Raw_Iron.png"),
		0,
		"Raw Iron",
		"Produced by Drills  [img]res://textures/buildings/drill/drill.png[/img]"
		)
