class_name Card extends Node2D

@export var CardName: String = "CardName"
@export var PlayDescription: String = "PlayDesc"
@export var ThrowDescription: String = "ThrowDesc"
@export var CardCost: int = 1
@export var CardImage: Node2D

@onready var CostLabel: Label = $CostDisplay/CostLabel
@onready var NameLabel: Label = $CardName/NameLabel 
@onready var PlayDescLabel: Label = $PlayDescription
@onready var ThrowDescLabel: Label = $ThrowDescription

func _ready():
	CostLabel.set_text(str(CardCost))
	NameLabel.set_text(CardName)
	PlayDescLabel.set_text(PlayDescription)
	ThrowDescLabel.set_text(ThrowDescription)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
