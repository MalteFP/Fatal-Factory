extends Button
class_name Item_button

var item_name: String
var item_discription: String
var id: int

func setup(item: Item):
	custom_maximum_size = Vector2(100,100)
	custom_minimum_size = Vector2(100,100)
	alignment = HORIZONTAL_ALIGNMENT_RIGHT
	expand_icon = true
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	item_name = item.title_name
	item_discription = item.discription
	icon = item.texture
	id = item.id
#Lundses was here
func _make_custom_tooltip(_for_text):
	var l = load("res://scenes/builder_tooltip.tscn")
	var label = l.instantiate()
	var rich_text_label: RichTextLabel = label.get_node("MarginContainer/VBoxContainer/RichTextLabel")
	rich_text_label.append_text(item_discription)
	

	label.setup(
		item_name, 
		icon
		)
	return label
	
	
	
	
	
	
	
	
