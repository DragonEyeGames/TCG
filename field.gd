extends Node2D

@export var field1: Node2D
@export var field2: Node2D
@export var field3: Node2D

var takenSlots=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player1Manager.field=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func permanent(index: int):
	var packed_card: PackedScene = load("res://Cards/" + str(GameManager.cards.keys()[index]) + ".tscn")
	var card_instance=packed_card.instantiate()
	add_child(card_instance)
	if(takenSlots==0):
		card_instance.global_position=field1.global_position
		takenSlots+=1
	elif(takenSlots==1):
		card_instance.global_position=field2.global_position
		takenSlots+=1
	elif(takenSlots==2):
		card_instance.global_position=field3.global_position
		takenSlots+=1
	else:
		Player1Manager.draw_card(index)
		return
	
	card_instance.position-=card_instance.pivot_offset
	card_instance.interactable=false
