class_name CardContainer extends Container

const CARD_COMPONENT_POSITION = Vector2(132,435)

var card: UsableCard:
	set(_card):
		remove_child(card)
		card = _card
		card.set_position(CARD_COMPONENT_POSITION)
		add_child(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
