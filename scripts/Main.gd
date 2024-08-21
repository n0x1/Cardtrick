extends Node2D

@export var player_character: Character

@onready var game_control: GameController = $GameController

var player_deck = [] # array to store players deck
var enemy_character_state: int = 0
var level: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	
	if $GameScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.GameState.GAMEOVER)
	elif $GameScreen/EnemyCharacter.health <= 0:
		game_control.transition(GameController.GameState.VICTORY)
	
	if game_control.current_state == GameController.GameState.ENEMY_TURN:
		#ai logic
		var enemydamagechange = $GameScreen/EnemyCharacter.damage_change # change this to iterate for multi enemy lvls
		if level == 1: #mushroom
			if enemy_character_state == 0:
				$GameScreen/EnemyCharacter.change_shield(3)
			elif enemy_character_state == 1:
				$GameScreen/PlayerCharacter.take_damage(2 + enemydamagechange)
			elif enemy_character_state == 2:
				$GameScreen/PlayerCharacter.take_damage(4 + enemydamagechange)
		if level == 2: # ghost
			pass
		
		enemy_character_state = posmod(enemy_character_state + 1, 3) # % but +
		game_control.transition(GameController.GameState.PLAYER_TURN)
		$GameScreen/PlayerCharacter.start_turn()
		
	if game_control.current_state == GameController.GameState.VICTORY:
		$CanvasLayer/VictoryOverlay.visible = true
	else:
		$CanvasLayer/VictoryOverlay.visible = false
		
	if game_control.current_state == GameController.GameState.GAMEOVER:
		$CanvasLayer/GameOverOverlay.visible = true
	else:
		$CanvasLayer/GameOverOverlay.visible = false


func _on_deck_hand_card_activated(staged_index, card: UsableCard, card_cost, action: String):
	var hand_node = get_node("DeckHand/Hand")
	if int($ManaAmount.get_text()) - card_cost >= 0:
		card.activate({
			"caster": $GameScreen/PlayerCharacter,
			"targets": [$GameScreen/EnemyCharacter], # change this to an index, or array if all things idk hard this is for debugging
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



func _on_end_turn_pressed():
	if game_control.current_state == GameController.GameState.PLAYER_TURN:
		game_control.transition(GameController.GameState.ENEMY_TURN)
		$GameScreen/EnemyCharacter.start_turn()


func _on_button_pressed(): # game over button
	game_control.current_state = GameController.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.max_health = 15 
	$GameScreen/PlayerCharacter.health = 15
	$GameScreen/PlayerCharacter.current_mana_cap = 3
	$GameScreen/PlayerCharacter.mana = 3
	$GameScreen/PlayerCharacter.shield = 0
	$GameScreen/PlayerCharacter.damage_change = 0
	$GameScreen/PlayerCharacter.bleeding = false
	$CanvasLayer/GameOverOverlay.visible = false


func _on_victory_button_pressed(): # victory
	level += 1
	$CanvasLayer/VictoryOverlay.visible = false
