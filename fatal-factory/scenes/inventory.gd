extends Node

var items: Dictionary

var id_to_item: Dictionary = {
	0: Dirt,
	1: Raw_Iron,
	2: Raw_Gold,
	3: Raw_Beryllium,
	4: Raw_Uranium,
	5: Energy,
	6: Hamster
}

func _ready() -> void:
	Saver.save_game.connect(save)

func item_collected(item: Item, amount: int):
	var item_id = item.id
	if items.keys().has(item_id):
		items[item_id] = items[item_id] + amount
	else:
		items[item_id] = amount
		get_tree().get_first_node_in_group("inventory_window").create_new_item(item)


func save():
	Saver.items = items
