@tool
class_name Character extends Node2D

@export var max_health: int = 100
@export var health: int = 100
@export var shield: int = 0
@export var mana: int = 5

func spend_mana(amount: int):
	if mana - amount >= 0:
		mana -= amount
		return true
	else:
		return false
		#display some message or error sound

func take_damage(amount: int):
	if shield > 0: # dmg first goes to shield
		shield -= amount
		if shield < 0:
			health += shield # shield will be negative so +
			shield = 0
	else:
		health -= amount

func change_shield(amount: int):
	shield += amount

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
	($"Healthbar/HealthText").set_text(str(health) + "/" + str(max_health))

func update_shield_icon_values():
	$"Shield".visible = shield > 0 # returns true or false
	$"Shield/ShieldNum".set_text(str(shield))
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_healthbar()
	update_shield_icon_values()

