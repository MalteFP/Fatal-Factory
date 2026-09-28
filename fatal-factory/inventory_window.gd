extends Window

@onready var grid: GridContainer = $MarginContainer/ScrollContainer/GridContainer

func _ready() -> void:
	get_window().size_changed.connect(_update_columns)
	
func _update_columns():
	var cell_width = 100
	grid.columns = max(1, floori(size.x / cell_width))


func _process(_delta: float) -> void:
	for item in grid.get_children():
		var index = grid.get_children().find(item)
		item.text = str(Inventory.items[index])


func create_new_item(item: Item) -> void:
	var button = Item_button.new()
	button.setup(item)
	grid.add_child(button)
