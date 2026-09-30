extends Window

@onready var grid: GridContainer = $MarginContainer/ScrollContainer/GridContainer

func _ready() -> void:
	get_window().size_changed.connect(_update_columns)
	
func _update_columns():
	var cell_width = 100
	grid.columns = max(1, floori(size.x / cell_width))
#Lundses was here

func _process(_delta: float) -> void:
	for button in grid.get_children():
		button.text = str(Inventory.items[button.id])


func create_new_item(item: Item) -> void:
	var button = Item_button.new()
	button.setup(item)
	grid.add_child(button)
