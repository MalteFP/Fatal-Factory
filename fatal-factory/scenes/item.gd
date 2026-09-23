extends Node2D
class_name Item


var sprite: Sprite2D
var texture: CompressedTexture2D 

func setup(item_texture: CompressedTexture2D):
	z_index = 1
	texture = item_texture
	build_children()
	sprite.texture = texture

func build_children():
	sprite = Sprite2D.new()
	add_child(sprite)
