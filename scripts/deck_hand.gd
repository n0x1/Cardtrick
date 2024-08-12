extends Node2D


@onready var SpawnPoint = $CanvasLayer/Spawn
@onready var claymore_card_scene: PackedScene = preload("res://scenes/cards/claymore.tscn")
@onready var shield_card_scene: PackedScene = preload("res://scenes/cards/shield.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var claymore_card = claymore_card_scene.instantiate()
	SpawnPoint.add_child(claymore_card)



func _on_button_2_pressed():
	var shield_card = shield_card_scene.instantiate()
	SpawnPoint.add_child(shield_card)
