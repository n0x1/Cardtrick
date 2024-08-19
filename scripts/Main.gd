extends Node2D

@export var player_character: Character

@onready var game_control: GameController = $GameController
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	if $GameScreen/PlayerCharacter.health <= 0:
		print("game over")
		# add actual mechanic so they acnt play


func _on_deck_hand_card_activated(staged_index, card: UsableCard, card_cost, action: String):
	var hand_node = get_node("DeckHand/Hand")
	if int($ManaAmount.get_text()) - card_cost >= 0:
		card.activate({
			"caster": $GameScreen/PlayerCharacter,
			"targets": [$GameScreen/EnemyCharacter], # change this to an index this is for debugging
			"card": card,
			"action": action
		})
		hand_node.remove_card(staged_index)
		hand_node.make_NEM_invisible()
	else:
		hand_node.unstage_cards()
		hand_node.show_NEM()
		print("not enough mana")
		




func _on_inflict_1_button_pressed():
	player_character.take_damage(1)


func _on_inflict_3_button_pressed():
	player_character.take_damage(3)

