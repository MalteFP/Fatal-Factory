extends Node

var items: Dictionary

func _ready() -> void:
	Saver.save_game.connect(save)

func item_collected(item: Item, amount: int):
	var item_id = item.id
	if items.keys().has(item_id):
		items[item_id] = items[item_id] + amount
		items["item"] = item
	else:
		items[item_id] = amount
		items["item"] = item
		get_tree().get_first_node_in_group("inventory_window").create_new_item(item)


func save():
	Saver.items = items
