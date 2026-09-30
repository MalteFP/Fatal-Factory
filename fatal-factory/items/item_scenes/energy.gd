extends Item

class_name Energy

func _init() -> void:
	setup(
		load(
		"res://textures/items/Lightning sprite.png"),
		5,
		"Energy",
		"Produced by Drills  [img]res://textures/items/Lightning sprite.png[/img]"
		)
