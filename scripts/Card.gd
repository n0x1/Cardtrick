class_name Card extends Node2D

@export var CardName: String = "CardName"
@export var PlayDescription: String = "PlayDesc"
@export var ThrowDescription: String = "ThrowDesc"
@export var CardCost: int = 1
@export var CardImage: Sprite2D

@onready var CostLabel: Label = $CostDisplay/CostLabel
@onready var NameLabel: Label = $CardName/NameLabel 
@onready var PlayDescLabel: Label = $PlayDescription
@onready var ThrowDescLabel: Label = $ThrowDescription

func _ready():
	set_card_values(CardCost, CardName, PlayDescription, ThrowDescription)
	visible = false

func set_card_values(_cost: int, _name: String, _play_desc: String, _throw_desc: String):
	CardCost = _cost
	CardName = _name
	PlayDescription = _play_desc
	ThrowDescription = _throw_desc
	
	CostLabel.set_text(str(_cost))
	NameLabel.set_text(_name)
	PlayDescLabel.set_text(_play_desc)
	ThrowDescLabel.set_text(_throw_desc)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	pass
 
