extends Button

@export var building_scene: PackedScene
@onready var builder = get_parent().get_parent().get_parent().get_parent()

var building_name: String
var building_cost: Array[Array]
var building_production: Array[Array]

func _ready() -> void:
	var temp = building_scene.instantiate()
	add_child(temp)
	building_name = temp.name
	icon = temp.icon
	tooltip_text = temp.tooltip
	building_cost = temp.cost
	building_production = temp.production
	temp.queue_free()





func _on_pressed() -> void:
	builder.deleting = false
	builder.set_building(building_scene)


func _make_custom_tooltip(_for_text):
	var l = load("res://builder_tooltip.tscn")
	var label = l.instantiate()
	var rich_text_label: RichTextLabel = label.get_node("MarginContainer/VBoxContainer/RichTextLabel")
	
	if building_production.size() > 0:
		rich_text_label.add_text("Production Per Min: ")
	
	for p in building_production:
		rich_text_label.append_text(str(p[0]) + " ")
		
		var item = p[1].instantiate()
		rich_text_label.append_text(item.name)
		rich_text_label.add_image(item.texture)
		if building_production.find(p) + 1 < building_production.size():
			rich_text_label.append_text(" + ")
	
	
	if building_cost.size() > 0:
		rich_text_label.add_text("\nCost: ")
	
	for c in building_cost:
		rich_text_label.append_text(str(c[0]) + " ")
		
		var item = c[1].instantiate()
		rich_text_label.append_text(item.name)
		rich_text_label.add_image(item.texture)
		if building_cost.find(c) + 1 < building_cost.size():
			rich_text_label.append_text(" + ")
		
		
	label.setup(
		building_name, 
		icon
		)
	return label
	
	
	
	
	
	
	
	
