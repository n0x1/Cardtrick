extends Node2D

func activate(game_state: Dictionary):
	#spend mana/cost
	var caster = game_state.get("caster")
	var targets = game_state.get("targets")
	var action = game_state.get("action") 
	
	if caster.spend_mana(2) == true: # can also implement function to get cost but const is easier
	
		if action == "play":
			play(caster)
		elif action == "throw":
			throw(caster, targets)
		elif action == "rip": # rip combines both effects
			play(caster)
			throw(caster, targets)
		else:
			print("INVALID action passed (??)!!!")
			return(null)
		

func play(caster):
	caster.change_shield(6) # gain 6 shield

func throw(caster, targets):
	if caster.shield > 0:
		targets[0].take_damage(12) 
	else:
		targets[0].take_damage(4) 
