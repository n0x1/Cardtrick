@tool
class_name Card extends Node2D

@export var CardName: String = "CardName"
@export var PlayDescription: String = "PlayDesc"
@export var ThrowDescription: String = "ThrowDesc"
@export var CardCost: int = 1
@export var CardImage: Sprite2D

@export var Thrown: bool = false # implement this later vv, ThrowDescription only shows when true

@onready var CostLabel: Label = $CostDisplay/CostLabel
@onready var NameLabel: Label = $CardName/NameLabel 
@onready var PlayDescLabel: Label = $PlayDescription
@onready var ThrowDescLabel: Label = $ThrowDescription

# throw description only shows after thrown

func _ready():
	set_card_values(CardCost, CardName, PlayDescription, ThrowDescription)


func set_card_values(_cost: int, _name: String, _play_desc: String, _throw_desc: String):
	CardCost = _cost
	CardName = _name
	PlayDescription = _play_desc
	ThrowDescription = _throw_desc
	
	_update_graphics()
	

func _update_graphics():
	
	if CostLabel.get_text() != str(CardCost):
		CostLabel.set_text(str(CardCost))
	if NameLabel.get_text() != CardName:
		NameLabel.set_text(CardName)
	if PlayDescLabel.get_text() != PlayDescription:
		PlayDescLabel.set_text(PlayDescription)
	if ThrowDescLabel.get_text() != ThrowDescription:
		ThrowDescLabel.set_text(ThrowDescription)


# deck: fan cards in arc of a circle, change angle of others when a card is hovered.
# hovered card grows and then use sin and cos to get position of other cards



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	_update_graphics()
 



func _on_area_2d_mouse_entered():
	pass # Replace with function body.

func _on_area_2d_mouse_exited():
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
