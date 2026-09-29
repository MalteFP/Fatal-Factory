extends Node

var items: Dictionary

func item_collected(item: Item, amount: int):
	var item_id = item.id
	if items.keys().has(item_id):
		items[item_id] = items[item_id] + amount
	else:
		items[item_id] = amount
		get_tree().get_first_node_in_group("inventory_window").create_new_item(item)
