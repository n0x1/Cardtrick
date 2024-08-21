extends Node2D

func activate(game_state: Dictionary):
	#spend mana/cost
	var caster = game_state.get("caster")
	var targets = game_state.get("targets")
	var action = game_state.get("action") 
	
	if caster.spend_mana(3) == true: # can also implement function to get cost but const is easier
		if action == "play":
			play(caster, targets)
		elif action == "throw":
			throw(caster, targets)
		elif action == "rip": # rip combines both effects
			throw(caster, targets) # shield breaks first
			play(caster, targets)
	
		else:
			print("INVALID action passed (??)!!!")
			return(null)
		

func play(caster, targets):
	for n in 3:
		targets[0].take_damage(2)
		targets[0].change_attack(-1)
		caster.play_sound("res://sounds/punch.mp3", 1)
		await caster.wait(0.3)

func throw(caster, targets):
	caster.play_sound("res://sounds/punch.mp3", 0.5) # playing anyways is funny 
	if targets[0].shield > 0:
		targets[0].shield = 0
