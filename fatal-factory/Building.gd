extends Node2D
class_name Building

var size: Vector2i
var texture: CompressedTexture2D

var output_res
var output_amount

func setup(building_size: Vector2i, building_texture: CompressedTexture2D, building_output_res, building_output_amount) -> void:
	size = building_size
	texture = building_texture
	output_res = building_output_res
	output_amount = building_output_amount
	
	
	$BuildingSprite.texture = self.texture
	
	build_collision_rect()
	



func build_collision_rect():
	var rect = RectangleShape2D.new()
	rect.size = size * 16 - Vector2i(1,1)
	$Area2D/CollisionShape2D.position = size * 8
	$Area2D/CollisionShape2D.set_shape(rect)
