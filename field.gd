extends Node2D

@export var field1: Node2D
@export var field2: Node2D
@export var field3: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player1Manager.field=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func permanent(index: int):
	var packed_card: PackedScene = load("res://Cards/" + str(GameManager.cards.keys()[index]) + ".tscn")
	var card_instance=packed_card.instantiate()
	if(len(field1.get_children())==0):
		field1.add_child(card_instance)
	elif(len(field2.get_children())==0):
		field2.add_child(card_instance)
	elif(len(field3.get_children())==0):
		field3.add_child(card_instance)
	else:
		Player1Manager.draw_card(index)
		return
	card_instance.position=-card_instance.pivot_offset
	card_instance.interactable=false
