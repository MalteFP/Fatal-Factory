extends Node2D
class_name Item


var sprite: Sprite2D
var texture: CompressedTexture2D 
var title_name: String
var id: int
var discription: String

func setup(item_texture: CompressedTexture2D, item_id: int, item_name: String, item_discription: String):
	z_index = 1
	title_name = item_name
	discription = item_discription
	texture = item_texture
	id = item_id
	build_children()
	sprite.texture = texture

func build_children():
	sprite = Sprite2D.new()
	add_child(sprite)
