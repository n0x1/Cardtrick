extends Node2D

@export var player_character: Character

@onready var game_control: GameController = $GameController
@onready var deck_view_overlay: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow
@onready var deck: Deck = Deck.new()

const PLAYER_STARTING_MAX_HP := 15

var enemy_character_state: int = 0
var level: int = 0
var enemies := []

var recovered_card = null

func enemies_all_dead():
	for enemy in enemies:
		if enemy.health > 0:
			return false
		print('all dead')
		return true

var enemy_base_damage: int = 2 # for enemies
var enemy_base_shield: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeckHand.deck = deck
	enemies.push_back($GameScreen/EnemyCharacter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !game_control.is_running:
		return # stop updates if game paused
	
	
	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	
	if $GameScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.GameState.GAMEOVER)
	elif enemies_all_dead() == true:
		game_control.transition(GameController.GameState.VICTORY)
	
	if game_control.current_state == GameController.GameState.ENEMY_TURN:
		#ai logic
		var enemydamagechange = $GameScreen/EnemyCharacter.damage_change # change this to iterate for multi enemy lvls
		if posmod(level, 5) == 0: #1 mushroom
			if enemy_character_state == 0:
				$GameScreen/EnemyCharacter.change_shield(enemy_base_shield)
			elif enemy_character_state == 1:
				$GameScreen/PlayerCharacter.take_damage(enemy_base_damage + enemydamagechange)
			elif enemy_character_state == 2:
				$GameScreen/PlayerCharacter.take_damage(2 + enemy_base_shield + enemydamagechange)
		if posmod(level, 5) == 1: # ghosts
			pass
		
		enemy_character_state = posmod(enemy_character_state + 1, 3) # % but +
		game_control.transition(GameController.GameState.PLAYER_TURN)
		$GameScreen/PlayerCharacter.start_turn()
		
	if game_control.current_state == GameController.GameState.VICTORY:
		$CanvasLayer/WinOverlay.visible = true
		var recoverable_thrown_cs = ($DeckHand/Hand as Hand).recoverable_thrown_cards
		var recovered_card = recoverable_thrown_cs.pick_random()
		$CanvasLayer/WinOverlay/RecoverText.set_text("Recovered" + str(recovered_card.name))

		
		
	if game_control.current_state == GameController.GameState.GAMEOVER:
		$CanvasLayer/GameOverOverlay.visible = true




func _on_deck_hand_card_activated(staged_index, card: UsableCard, card_cost, action: String):
	var hand_node = get_node("DeckHand/Hand")
	if int($ManaAmount.get_text()) - card_cost >= 0:
		card.activate({
			"caster": $GameScreen/PlayerCharacter,
			"targets": [$GameScreen/EnemyCharacter], # change this to an index, or array if all things idk hard this is for debugging
			"card": card,
			"action": action
		})
		if action == "play":
			$DeckHand/Hand.discard(staged_index)
		if action == "throw":
			$DeckHand/Hand.recoverable_thrown_cards.push_back($DeckHand/Hand.hand[staged_index])
			$DeckHand/Hand.remove_card(staged_index)
		if action == "rip":
			$DeckHand/Hand.remove_card(staged_index)
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
		get_node("DeckHand/Hand").unstage_cards()
		


func _on_button_pressed(): # restart the game
	game_control.current_state = GameController.GameState.PLAYER_TURN
	
	level = 0
	
	$GameScreen/PlayerCharacter.max_health = PLAYER_STARTING_MAX_HP 
	$GameScreen/PlayerCharacter.health = PLAYER_STARTING_MAX_HP
	$GameScreen/PlayerCharacter.current_mana_cap = 3
	$GameScreen/PlayerCharacter.mana = 3
	$GameScreen/PlayerCharacter.shield = 0
	$GameScreen/PlayerCharacter.damage_change = 0
	$GameScreen/PlayerCharacter.bleeding = false
	
	$CanvasLayer/GameOverOverlay.visible = false
	$GameScreen/PlayerCharacter.show()
	recovered_card = null
	
	enemies.clear()
	
	enemies.push_back($GameScreen/EnemyCharacter)
	enemy_base_damage = 2 # this is init, it increases every win
	enemy_base_shield = 3
	reset_enemy_stats()



func reset_enemy_stats(): # just for game over restart for now
	for enemy in enemies:
		enemy.shield = 0
		enemy.damage_change = 0
		enemy.max_health = 15
		enemy.health = 15
		enemy.bleeding = false
		enemy.show()


func _on_deck_button_pressed():
	if deck_view_overlay.visible == false:
		show_deck_view()
	else:
		hide_deck_view()



func _on_deck_hand_hide_deck_view():
	hide_deck_view()

func show_deck_view():
	(game_control as GameController).pause()
	deck_view_overlay.visible = true
	deck_view_overlay.display_card_list(deck.get_cards()) # pass array of list of UsableCard s
	$CanvasLayer/DeckViewBgRect.visible = true
	(get_node("DeckHand/Hand") as Hand).unstage_cards()

func hide_deck_view():
	(game_control as GameController).resume()
	deck_view_overlay.visible = false
	$CanvasLayer/DeckViewBgRect.visible = false
	


func _on_button_v_pressed(): #victory button
	game_control.current_state = GameController.GameState.PLAYER_TURN
	($DeckHand as DeckNHand).add_to_deckview_and_hand(recovered_card)
	enemies.clear()
	$CanvasLayer/WinOverlay.visible = false
	level += 1
	#increase difficulty
	enemy_base_damage += floor(level / 2)# this is init, it increases every win
	enemy_base_shield += floor(level / 2)
	
