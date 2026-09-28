extends Node2D

func _ready() -> void:
	var item = Iron.new()
	Inventory.item_collected(item, 50)
	
	var hub = Hub.new()
	add_child(hub)
	hub.just_placed()
