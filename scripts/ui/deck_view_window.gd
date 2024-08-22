class_name DeckViewWindow extends ScrollContainer

@onready var card_container_scene: PackedScene = preload("res://scenes/ui/card_container.tscn")

@onready var flow_container = $HFlowContainer

func clear_display():
	for child in flow_container.get_children():
		flow_container.remove_child(child)
		child.queue_free()

func display_card_list(cardsWithID: Array[CardWithID]):
	clear_display()
	
	for cardWithID in cardsWithID:
		var card_container: CardContainer = card_container_scene.instantiate() as CardContainer
		card_container.card = (cardWithID as CardWithID).card
		flow_container.add_child(card_container)

