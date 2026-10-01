extends Node2D
class_name Building

var level: int = 1

var size: Vector2i
var sprite_frames: SpriteFrames

var output_res
var output_amount

var cost
var production
var tooltip
var upgrade_pop_up

var sprite: AnimatedSprite2D
var area: Area2D
var collision_shape: CollisionShape2D
var icon

var rotatable: bool
var mirrorable: bool

var placed = false

var partial_building: bool = false

var child_buildings: Array[Building]

func setup(building_name: String, building_size: Vector2i, building_sprite_frames: SpriteFrames, building_icon: CompressedTexture2D, building_tooltip: String, building_cost: Array[Array], building_production: Array[Array] = []) -> void:
	size = building_size
	name = building_name
	sprite_frames = building_sprite_frames
	tooltip = building_tooltip
	icon = building_icon
	cost = building_cost
	production = building_production
	build_children()
	
	sprite.sprite_frames = sprite_frames
	build_collision_rect()
	
	area.mouse_shape_entered.connect(_mouse_entered_area)
	area.mouse_shape_exited.connect(_mouse_exited_area)
	area.input_event.connect(_on_area_input_event)
	
	sprite.play("default")

func just_placed():
	just_placed_building_special()
	placed = true
	var p = load("res://upgrade_pop_up.tscn")
	upgrade_pop_up = p.instantiate()
	add_child(upgrade_pop_up)
	

func build_collision_rect():
	var rect = RectangleShape2D.new()
	rect.size = size * 16 - Vector2i(1,1)
	collision_shape.position = size * 8
	collision_shape.set_shape(rect)
	area.collision_layer = (1 << 0)


func build_children():
	sprite = AnimatedSprite2D.new()
	sprite.centered = false
	add_child(sprite)
	
	area = Area2D.new()
	add_child(area)
	
	collision_shape = CollisionShape2D.new()
	area.add_child(collision_shape)
	
func delete():
	for c in cost:
		Inventory.item_collected(c[1], c[0])
	queue_free()

func _mouse_entered_area(_shape_idx):
	if partial_building or not placed:
		return
	sprite.modulate = Color(0.622, 0.622, 0.622, 1.0)

func _mouse_exited_area(_shape_idx):
	if partial_building or not placed:
		return
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_area_input_event(_viewport, event, _shape_idx):
	if partial_building or not placed:
		return
	if event is InputEvent and Input.is_action_just_pressed("click"):
		upgrade_pop_up.appear()


func just_placed_building_special():
	pass


func level_up():
	level += 1
	for child in child_buildings:
		child.level_up()
