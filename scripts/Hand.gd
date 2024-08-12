@tool
class_name Hand extends Node2D

@export var hand_radius: int = 100
@export var card_angle: float = -90

 
@onready var test_card = $test_card #test
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []


func add_card(card: Node2D):
	hand.push_back(card)

func reposition_cards():
	for card in hand :
		pass
		


func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(x, y)
	
func _card_transform_update(card: Node2D, angle_in_drag: float):
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	collision_shape = $DebugShape
	# tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)
		
	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(deg_to_rad(card_angle + 90))
