extends Window

@onready var grid: GridContainer = $MarginContainer/ScrollContainer/GridContainer

func _ready() -> void:
	get_window().size_changed.connect(_update_columns)
	
func _update_columns():
	var cell_width = 100
	grid.columns = max(1, floori(size.x / cell_width))
