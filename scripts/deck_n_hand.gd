extends Node2D

signal card_activated(card, action: String)

@onready var ccs: PackedScene = preload("res://scenes/cards/claymore.tscn")
@onready var shield_card_scene: PackedScene = preload("res://scenes/cards/shield.tscn")
@onready var blizzard_card_scene: PackedScene = preload("res://scenes/cards/blizzard.tscn")
@onready var brassknuckle_card_scene: PackedScene = preload("res://scenes/cards/brassknuckle.tscn")

@onready var hand = $Hand
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var c = ccs.instantiate()
	hand.add_card(c)


func _on_button_2_pressed():
	var d = shield_card_scene.instantiate()
	hand.add_card(d)


func _on_hand_card_activated(staged_index, card, card_cost, action): # bring up to Main node
	card_activated.emit(staged_index, card, card_cost, action)
