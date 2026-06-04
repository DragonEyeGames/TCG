extends Card

func onDamage():
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
	
	inspirationLevel+=1
				
	GameManager.actionBoxText.text="Gained 1 Inspiration"
	await get_tree().create_timer(1).timeout
	
	GameManager.actionBoxText.text="Current Inspiration Level: " + str(inspirationLevel)
	await get_tree().create_timer(1).timeout
				
	z_index=backupZ
	display=backupDisplay
	interactable=backupInteractable
	scale=backupScale
	followMouse=backupMouse
	global_position = backupPos
	GameManager.actionBox.visible=false
	Player1Manager.hand_lock=false
				
	GameManager.actionFinished()
