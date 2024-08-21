@tool
class_name Character extends Node2D

@export var sprite_texture: CompressedTexture2D
@export var max_health: int = 25
@export var health: int = 25
@export var shield: int = 0
@export var mana: int = 3
@export var current_mana_cap: int = 3
@export var damage_change: int = 0 # positive indicates buff and negative nerfs
func spend_mana(amount: int):
	if mana - amount >= 0:
		mana -= amount
		return true
	else:
		return false
		#display some message or error sound

func take_damage(amount: int):
	if amount > 0:
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
	damage_change += amount # use negatives to debuff
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
	if health < 0:
		health = 0 #(for consistency with visuals)
	($"Healthbar/HealthText").set_text(str(health) + "/" + str(max_health))

func update_shield_icon_values():
	$"Shield".visible = shield > 0 # returns true or false
	$"Shield/ShieldNum".set_text(str(shield))
	$"AttackChange".visible = damage_change != 0 
	if damage_change > 0:
		$"AttackChange/AttackChgNum".set_text("+" + str(damage_change))
	else:
		$"AttackChange/AttackChgNum".set_text(str(damage_change))
	
	
func start_turn():
	if shield > 0: 
		shield -=1 # decay so balanced ig
	if damage_change > 0: #decay
		damage_change -= 1
	elif damage_change < 0:
		damage_change += 1
	mana = current_mana_cap
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_healthbar()
	update_shield_icon_values()
	

