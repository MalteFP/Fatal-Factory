extends Node

const save_location = "user://Savefile.json"
var contentToSave = {}
var buildings: Array[Dictionary] = [{}]
var items: Dictionary
var map_seed: int


signal save_game()

func save():
	buildings.clear()
	save_game.emit()
	contentToSave["buildings"] = buildings
	contentToSave["map_seed"] = map_seed
	contentToSave["items"] = items
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contentToSave.duplicate())
	file.close()


func load_game():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		contentToSave = file.get_var()
		file.close()
		unpack_save()


func unpack_save():
	buildings = contentToSave["buildings"]
	map_seed = contentToSave["map_seed"]
	items = contentToSave["items"]
	
func build_buildings():
	await get_tree().create_timer(0).timeout
	var world = get_tree().get_first_node_in_group("world")
	for building in buildings:
		var script = load(building["script"])
		var b = script.new()
		world.add_child(b)
		b.global_position = building["position"]
		b.rotation = building["rotation"]
		b.scale = building["scale"]
		b.just_placed()
