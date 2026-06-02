extends Node2D

@export var player1=true
@export var decklist: Array[GameManager.cards] = []
var discard: Array[GameManager.cards] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(player1):
		Player1Manager.deck=self
	else:
		Player2Manager.deck=self
	var original = $card
	original.visible=false
	for i in range (0, len(decklist)):
		var card=original.duplicate()
		add_child(card)
		card.position.y-=randi_range(15, 22)
		card.position.x=randi_range(-10, 10)
		original=card
		card.visible=true
	decklist.shuffle()
	
func draw_card():
	if(len(decklist)<=0):
		shuffleDiscard()
	get_child(-1).queue_free()
	if(player1):
		Player1Manager.draw_card(decklist[0])
	else:
		Player2Manager.draw_card(decklist[0])
	decklist.remove_at(0)

func shuffleDiscard():
	print("shufflin'")
	decklist=discard.duplicate()
	decklist.shuffle()
	discard.clear()
	var original = $card
	for i in range (0, len(decklist)):
		var card=original.duplicate()
		add_child(card)
		card.position.y-=randi_range(15, 22)
		card.position.x=randi_range(-10, 10)
		original=card
		card.visible=true
	decklist.shuffle()
	if(player1):
		for child in Player1Manager.discardPile.get_children():
			child.queue_free()
	if(!player1):
		for child in Player2Manager.discardPile.get_children():
			child.queue_free()
