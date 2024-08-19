extends Node2D

@export var player_character: Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	$GameScreen/PlayerCharacter/ShieldNum.set_text(str($GameScreen/PlayerCharacter.shield))
	if $GameScreen/PlayerCharacter.health <= 0:
		print("game over")
		# add actual mechanic so they acnt play


func _on_deck_hand_card_activated(card: UsableCard, action: String):
	card.activate({
		"caster": $GameScreen/PlayerCharacter,
		"targets": [$GameScreen/EnemyCharacter], # change this to an index this is for debugging
		"card": card,
		"action": action
	})


func _on_inflict_1_button_pressed():
	player_character.take_damage(1)


func _on_inflict_3_button_pressed():
	player_character.take_damage(3)

