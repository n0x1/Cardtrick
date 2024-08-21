@tool
class_name Character extends Node2D

@export var sprite_texture: CompressedTexture2D
@export var max_health: int = 15
@export var health: int = 15
@export var shield: int = 0
var mana: int = 3
var current_mana_cap: int = 3
@export var damage_change: int = 0 # positive indicates buff and negative nerfs
@export var bleeding: bool = false
var saved_amount: int = 0 # forbleeding
var saved_turns: int = 0 # forbleeding

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

var bleedcount = 0 #init 
func bleed(amount: int, turns: int):
	if bleedcount == 0:
		saved_amount = amount
		saved_turns = turns
	if bleeding == true:
		bleedcount += 1
		saved_turns -= 1
		take_damage(saved_amount)
		if turns <= 1:
			bleedcount = 0
			bleeding = false
	if health < 0:
			bleeding = false
			bleedcount = 0

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
	$Bleeding.visible = bleeding
	if damage_change > 0:
		$"AttackChange/AttackChgNum".set_text("+" + str(damage_change))
	else:
		$"AttackChange/AttackChgNum".set_text(str(damage_change))
	if bleeding == true:
		$Bleeding/BleedingLabel.set_text("-" + str(saved_amount))
		$Bleeding/TurnLabel.set_text(str(saved_turns))
	else:
		$Bleeding/BleedingLabel.set_text("")
		$Bleeding/TurnLabel.set_text("")
		
	
func start_turn():
	if shield > 0: 
		shield -=1 # decay so balanced ig
		
	if damage_change > 0: #decay
		damage_change -= 1
	elif damage_change < 0:
		damage_change += 1
		
	if bleeding == true:
		bleed(saved_amount, saved_turns)
		
	mana = current_mana_cap
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_healthbar()
	update_shield_icon_values()
	

