extends Node2D

signal card_activated(card, action: String)
signal hide_deck_view()
@export var deck: Deck


@onready var ccs: PackedScene = preload("res://scenes/cards/claymore.tscn")
@onready var scs: PackedScene = preload("res://scenes/cards/shield.tscn")
@onready var blizzard_card_scene: PackedScene = preload("res://scenes/cards/blizzard.tscn")
@onready var brassknuckle_card_scene: PackedScene = preload("res://scenes/cards/brassknuckle.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_to_deckview_and_hand(card):
	deck.add_card(card)
	$Hand.add_card(card)

func _on_button_pressed():
	var c = ccs.instantiate()
	add_to_deckview_and_hand(c) # only when adding first or throw recover, not if its discarded



func _on_button_2_pressed():
	var d = scs.instantiate()
	add_to_deckview_and_hand(d)



func _on_hand_card_activated(staged_index, card, card_cost, action): # bring up to Main node
	card_activated.emit(staged_index, card, card_cost, action)


#func _on_remove_button_pressed():
	#if deck.get_cards().is_empty():
	#	return
	
	#var randomcard: CardWithID = deck.get_cards().pick_random()
	#deck.remove_card(randomcard.id)


func _on_hand_hide_deck_view():
	hide_deck_view.emit()
