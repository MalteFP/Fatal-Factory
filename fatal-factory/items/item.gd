extends Node2D
class_name Item


var sprite: Sprite2D
var area: Area2D
var collision_shape: CollisionShape2D
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
	
	area = Area2D.new()
	add_child(area)
	
	area.collision_layer = (1 << 1)
	
	collision_shape = CollisionShape2D.new()
	area.add_child(collision_shape)
	build_collision_rect()

func build_collision_rect():
	var rect = RectangleShape2D.new()
	rect.size = Vector2(12,12)
	collision_shape.set_shape(rect)
	
