class_name Deck extends Resource

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
	var cards: Array[CardWithID] = []
	if !card_collection.is_empty():
		for card in card_collection.values():
			cards.push_back(card as CardWithID)
		return cards 
		
	# ideally it shouldnt be empty, try to limit at 1 card 
	# OR when its empty, discard pile drawn
	return cards

func _generate_card_id(card: UsableCard):
	return id_counter
