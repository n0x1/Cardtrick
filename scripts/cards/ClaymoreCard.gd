class_name UsableCard extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)


func _ready():
	pass
	
func _process(delta):
	pass

func highlight():
	$Card.highlight()

func unhighlight():
	$Card.unhighlight()

func staged_highlight():
	$Card.staged_highlight($CardImage)
	
func _on_card_mouse_entered(card: Card):
	mouse_entered.emit(self)

func _on_card_mouse_exited(card: Card):
	mouse_exited.emit(self)

func _on_card_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		pass
