@tool
class_name Character extends Node2D

@export var max_health: int = 10
@export var health: int = 10
@export var mana: int = 5

func spend_mana(amount: int):
	#if mana - amount >= 0:
	mana -= amount
	#else:
		#display some message or error sound
	pass

func take_damage(amount: int):
	health -= amount
	pass

func change_shield(shield: int):
	#player_shield += shield
	pass

func change_attack(amount: int):
	# attack += amount
	pass




func set_health_values(_health: int, _max_health: int):
	max_health = _max_health
	health = _health
	update_healthbar()
	
func update_healthbar(): # hp bar graphical update only
	if ($Healthbar as ProgressBar).max_value != max_health:
		($Healthbar as ProgressBar).max_value = max_health 
	if ($Healthbar as ProgressBar).value != health:
		($Healthbar as ProgressBar).value = health
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_healthbar()

