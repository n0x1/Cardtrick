class_name Deck extends RefCounted

var card_collection: Dictionary = {}

var id_counter: int = 0

func add_card(card: UsableCard): # add to deck
	var card_id = _generate_card_id(card)
	card_collection[card_id] = CardWithID.new(card_id, card)
	id_counter += 1

func remove_card(card_id: int): # remove from deck
	card_collection.erase(card_id)

func update_card(card_id: int, card: UsableCard):
	card_collection[card_id] = card 

func get_cards() -> Array[CardWithID]:
	
	return card_collection.values()

func _generate_card_id(card: UsableCard):
	return id_counter
