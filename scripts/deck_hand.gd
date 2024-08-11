extends Node2D

@onready var CardScene: PackedScene = preload("res://scenes/Card.tscn")

@onready var SpawnPoint = $CanvasLayer/Spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var card: Card = CardScene.instantiate()
	SpawnPoint.add_child(card)
	card.set_card_values(1, "cardname", "play", "throw")
	card.visible = true


func _on_button_2_pressed():
	var card: Card = CardScene.instantiate()
	SpawnPoint.add_child(card)
	card.set_card_values(2, "n2", "p2", "t2")
	card.visible = true
