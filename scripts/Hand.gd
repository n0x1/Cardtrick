@tool
class_name Hand extends Node2D

@export var hand_radius: int = 1
@export var card_angle: float = -90
@export var angle_limit: float = 75 #25
@export var max_card_spread_angle: float = 180 # 5

@onready var test_card = $test_card #test
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []
var highlight_index: int = -1

func add_card(card: Node2D):
	hand.push_back(card)
	add_child(card)
	card.mouse_entered.connect(_handle_card_touched)
	card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()

func remove_card(index: int):
	var removing_card = hand[index]
	hand.remove_at(index)
	remove_child(removing_card)
	reposition_cards()
	return removing_card # removed from data but returned



func reposition_cards():
	var card_spread = min(angle_limit / hand.size(), max_card_spread_angle)
	var current_angle = -(card_spread * (hand.size() - 1))/2 - 90
	for card in hand :
		_update_card_transform(card, current_angle)
		current_angle += card_spread
		
		


func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(int(x), int(y))
	
func _update_card_transform(card: Node2D, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag+90))
	

func _handle_card_touched(card: Card):
	var card_index = hand.find(card)
	if highlight_index < card_index:
		highlight_index = card_index
	print("touched: " + card.CardName)
	
func _handle_card_untouched(card: Card):
	var card_index = hand.find(card)
	if highlight_index == card_index:
		hand[highlight_index].unhighlight()
		highlight_index = -1
	print("untouched: " + card.CardName)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if highlight_index >= 0 && highlight_index < hand.size():
		hand[highlight_index].highlight()
	
	collision_shape = $DebugShape
	# tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)
	
	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(deg_to_rad(card_angle + 90))
