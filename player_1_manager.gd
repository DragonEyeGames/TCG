extends Node

var hand: Node2D

func draw_card(index: int):
	#print(str(GameManager.cards.keys()[index]))
	print("loading...")
	var packed_card: PackedScene = load("res://Cards/" + str(GameManager.cards.keys()[index]) + ".tscn")
	var card_instance=packed_card.instantiate()
	hand.get_node("CardHolder").add_child(card_instance)
