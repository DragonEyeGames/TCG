extends Node

var hand: Node2D
var discardPile: Node2D

var handOpen=false

func draw_card(index: int):
	#print(str(GameManager.cards.keys()[index]))
	var packed_card: PackedScene = load("res://Cards/" + str(GameManager.cards.keys()[index]) + ".tscn")
	var card_instance=packed_card.instantiate()
	hand.get_node("CardHolder").add_child(card_instance)

func discard(index: int):
	var packed_card: PackedScene = load("res://Cards/" + str(GameManager.cards.keys()[index]) + ".tscn")
	var card_instance=packed_card.instantiate()
	if(len(discardPile.get_children())>0):
		print("more")
		card_instance.position.y=discardPile.get_child(-1).position.y-randi_range(15, 22)
		card_instance.position.x=randi_range(-10, 10)
	else:
		card_instance.position=Vector2.ZERO
	discardPile.add_child(card_instance)
