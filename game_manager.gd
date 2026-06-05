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
	permanent,
	temporary,
	instant,
	champion,
	creature,
	player1,
	player2
}

const cardCosts = {
	cards.midas_touch: 2,
	cards.bugbear: 2,
	cards.ironbound_knight: 0,
	cards.warlord_of_ash: 0,
	cards.temple_guardian: 2,
	cards.quick_snack: 1,
	cards.battle_cry: 1,
	cards.heavy_swing: 2,
	cards.golden_opportunity: 1
}

var diceManager: Node3D

var player1Turn=false

var swapping=false

var targeting=false

var targetParameters: Array[types] = []

var potentialTarget=null
var target=null

var actionBox: Node2D
var actionBoxText: RichTextLabel
var actionLine: Line2D

var zoom: Node2D

var activeActions=0

func actionSlot():
	prints(activeActions, " ACTIVE ABILITIES")
	var backupSlot=activeActions
	activeActions+=1
	if(backupSlot!=0):
		while activeActions!=backupSlot:
			await get_tree().process_frame
	print("GOOD BOY")
	return

func actionFinished():
	activeActions-=1

func set_target():
	targeting=true
	Player1Manager.hand_lock=true
	target=null
	while target==null:
		await get_tree().process_frame
	targeting=false
	potentialTarget=null
	var backupTarget=target
	target=null
	return backupTarget

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
	var card_type = scene.attributes[0]
	
	if(Player1Manager.actions-cardCosts[card]<0):
		Player1Manager.draw_card(card)
		return
	
	Player1Manager.actions-=cardCosts[card]
	
	scene.display=true
	scene.interactable=false
	scene.scale=Vector2(2.3, 2.3)
	scene.followMouse=false
	scene.global_position = Vector2(2792, -1721)
	Player1Manager.hand_lock=true
	await scene.onPlay()
	Player1Manager.hand_lock=false
	if(scene.consumed):
		print("DEAD")
	
	if(card_type==types.instant):
		Player1Manager.discard(card)
		
	if(card_type==types.permanent):
		Player1Manager.permanent(card)
	scene.queue_free()

func ability(scene: Card):
	scene.z_index=4
	scene.display=true
	scene.interactable=false
	scene.scale=Vector2(2.3, 2.3)
	scene.followMouse=false
	scene.global_position = Vector2(2792, -1721)
	Player1Manager.hand_lock=true
