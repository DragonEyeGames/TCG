extends Node

var hand: Node2D
var discardPile: Node2D
var field: Node2D
var deck: Node2D

var handOpen=false

var actions=3

var active = []

var champion

func draw_card(index: int):
	var packed_card: PackedScene = load("res://card_back.tscn")
	var card_instance=packed_card.instantiate()
	card_instance.cardType=index
	hand.get_node("CardHolder").add_child(card_instance)

func discard(index: int):
	var packed_card: PackedScene = load("res://Cards/" + str(GameManager.cards.keys()[index]) + ".tscn")
	var card_instance=packed_card.instantiate()
	if(len(discardPile.get_children())>0):
		card_instance.position.y=discardPile.get_child(-1).position.y-randi_range(15, 22)
		card_instance.position.x=randi_range(-10, 10)
	else:
		card_instance.position=Vector2.ZERO
	discardPile.add_child(card_instance)
	card_instance.interactable=false
	deck.discard.append(index)

func permanent(index: int):
	field.permanent(index)
