extends Node2D
class_name Building

var size: Vector2i
var sprite_frames: SpriteFrames

var output_res
var output_amount

var cost
var tooltip

var sprite: AnimatedSprite2D
var area: Area2D
var collision_shape: CollisionShape2D
var icon

var rotatable: bool
var mirrorable: bool

var placed = false


func setup(building_size: Vector2i, building_sprite_frames: SpriteFrames, building_icon: CompressedTexture2D, building_tooltip: String, building_output_res, building_output_amount) -> void:
	size = building_size
	sprite_frames = building_sprite_frames
	tooltip = building_tooltip
	icon = building_icon
	output_res = building_output_res
	output_amount = building_output_amount
	
	build_children()
	
	sprite.sprite_frames = sprite_frames
	build_collision_rect()
	
	sprite.play("default")
	

func just_placed():
	pass

func build_collision_rect():
	var rect = RectangleShape2D.new()
	rect.size = size * 16 - Vector2i(1,1)
	collision_shape.position = size * 8
	collision_shape.set_shape(rect)


func build_children():
	sprite = AnimatedSprite2D.new()
	sprite.centered = false
	add_child(sprite)
	
	area = Area2D.new()
	add_child(area)
	
	collision_shape = CollisionShape2D.new()
	area.add_child(collision_shape)
	
func delete():
	queue_free()
