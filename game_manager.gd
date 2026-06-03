extends Node

enum cards {
	midas_touch,
	bugbear,
	ironbound_knight,
	warlord_of_ash,
	temple_guardian,
	quick_snack,
	battle_cry,
	heavy_swing,
	golden_opportunity
}

enum types {
	minion,
	equipment,
	item,
	permanent_arcana,
	temporary_arcana,
	instant_arcana,
	champion
}

const cardTypes = {
	cards.midas_touch: types.instant_arcana,
	cards.bugbear: types.minion,
	cards.ironbound_knight: types.champion,
	cards.warlord_of_ash: types.champion,
	cards.temple_guardian: types.minion,
	cards.quick_snack: types.instant_arcana,
	cards.battle_cry: types.instant_arcana,
	cards.heavy_swing: types.instant_arcana,
	cards.golden_opportunity: types.instant_arcana
}

const cardCosts = {
	cards.midas_touch: 2,
	cards.bugbear: 2,
	cards.ironbound_knight: 0,
	cards.warlord_of_ash: 0,
	cards.temple_guardian: 2,
	cards.quick_snack: 1,
	cards.battle_cry: 1,
	cards.heavy_swing: 1,
	cards.golden_opportunity: 1
}

var diceManager: Node3D

var player1Turn=false

var swapping=false

func endTurn():
	swapping=true
	player1Turn=!player1Turn
	if(player1Turn):
		print("Player1's turn")
		for card in Player2Manager.hand.get_node("CardHolder").get_children():
			Player2Manager.discard(card.cardType)
			card.queue_free()
		Player1Manager.deck.draw_card()
		await get_tree().process_frame
		Player1Manager.deck.draw_card()
		await get_tree().process_frame
		Player1Manager.deck.draw_card()
		await get_tree().process_frame
		Player1Manager.deck.draw_card()
		await get_tree().process_frame
		Player1Manager.actions=3
		swapping=false
	else:
		print("Player2's turn")
		for card in Player1Manager.hand.get_node("CardHolder").get_children():
			Player1Manager.discard(card.cardType)
			card.queue_free()
		Player2Manager.deck.draw_card()
		await get_tree().process_frame
		Player2Manager.deck.draw_card()
		await get_tree().process_frame
		Player2Manager.deck.draw_card()
		await get_tree().process_frame
		Player2Manager.deck.draw_card()
		await get_tree().process_frame
		Player2Manager.actions=3
		endTurn()

func play(card: cards, scene: Card):
	var card_type = cardTypes[card]
	
	if(Player1Manager.actions-cardCosts[card]<0):
		Player1Manager.draw_card(card)
		return
	
	Player1Manager.actions-=cardCosts[card]
	
	if(card_type==types.instant_arcana):
		Player1Manager.discard(card)
		
	if(card_type==types.minion):
		Player1Manager.permanent(card)
	scene.visible=false
	await scene.onPlay()
	scene.queue_free()
