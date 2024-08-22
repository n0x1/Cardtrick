class_name CardContainer extends Container

var card: UsableCard:
	set(_card):
		card = _card
		card.position(Vector2(132, 435))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
