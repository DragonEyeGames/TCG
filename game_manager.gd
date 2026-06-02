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

func play(card: cards):
	print(cards.keys()[card])
	var card_type = cardTypes[card]
	
	if(card_type==types.instant_arcana):
		Player1Manager.discard(card)
