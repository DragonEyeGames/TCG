extends Card

func successfulStrike():
	print("Hishankah")
	
	var backupZ=z_index
	var backupDisplay=display
	var backupInteractable=interactable
	var backupScale=scale
	var backupMouse=followMouse
	var backupPos=global_position
	
	await GameManager.actionSlot()
	print("YAY")
	GameManager.ability(self)
	GameManager.actionBox.visible=true
	GameManager.actionBoxText.text="Resolving Ability"
	await get_tree().create_timer(1.5).timeout
	if(player1):
		#print(Player2Manager.active)
		for goober in Player2Manager.active:
			if(goober.creature):
				GameManager.actionLine.visible=true
				GameManager.actionLine.points[1]=goober.global_position
				GameManager.actionLine.points[1].y+=700
				GameManager.actionLine.points[1].x+=500
				goober.health-=1
				var cardName = GameManager.cards.keys()[goober.cardType]
				cardName=cardName.replace("_", " ")
				GameManager.actionBoxText.text="Damaged " + cardName
				await get_tree().create_timer(1).timeout
				GameManager.actionLine.visible=false
				
	z_index=backupZ
	display=backupDisplay
	interactable=backupInteractable
	scale=backupScale
	followMouse=backupMouse
	global_position = backupPos
	GameManager.actionBox.visible=false
	Player1Manager.hand_lock=false
				
	GameManager.actionFinished()
