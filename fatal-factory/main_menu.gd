extends Control



func _on_new_game_pressed() -> void:
	var scene = preload("res://scenes/world.tscn")
	var world = scene.instantiate()
	world.map_seed = randi()
	world.build_world()
	get_tree().change_scene_to_node(world)


func _on_load_game_pressed() -> void:
	Saver.load_game()
	var scene = preload("res://scenes/world.tscn")
	var world = scene.instantiate()
	world.map_seed = Saver.map_seed
	world.build_world()
	get_tree().change_scene_to_node(world)
	Saver.build_buildings()
