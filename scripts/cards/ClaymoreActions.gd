extends Node2D

func activate(game_state: Dictionary):
	var caster = game_state.get("caster")
	var card = game_state.get("card")
	var index = game_state.get("target_index")
	var targets = game_state.get("targets")
	var action = game_state.get("action") 
	#spend mana/cost
	if caster.spend_mana(1) == true: # can also implement function to get cost but const in code is easy
		caster.play_sound("res://sounds/slash.mp3", 1)
		if action == "play":
			play(targets, index)
		elif action == "throw":
			throw(targets, index)
		elif action == "rip": # rip combines both effects
			play(targets, index)
			throw(targets, index)
		else:
			print("INVALID action passed (??)!!!")
			return(null)
			

		
		
		
		
		

func play(targets, index):
	targets[index].take_damage(3) # single target

func throw(targets,index):
	targets[index].take_damage(2) # single target
	targets[index].change_attack(-2) # reduce their Attack by 2
