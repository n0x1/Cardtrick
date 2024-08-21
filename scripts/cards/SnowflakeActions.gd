extends Node2D

func activate(game_state: Dictionary):
	#spend mana/cost
	var caster = game_state.get("caster")
	var targets = game_state.get("targets")
	var action = game_state.get("action") 
	
	if caster.spend_mana(3) == true: 
		caster.play_sound("res://sounds/blizzard.mp3", 1)
		if action == "play":
			play(targets)
		elif action == "throw":
			throw(targets)
		elif action == "rip": # rip combines both effects
			play(targets)
			throw(targets)
		else:
			print("INVALID action passed (??)!!!")
			return(null)
		
		

func play(targets):
	for target in targets:
		target.take_damage(5)

func throw(targets):
	for target in targets:
		if target.bleeding != true:
			target.bleeding = true
			target.bleed(3, 5)
		else:
			target.saved_turns += 5 # just extend otherwise.
			
