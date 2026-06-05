extends Card

func onPlay():
	GameManager.actionBox.visible=true
	GameManager.actionBoxText.text="Pick your target"
	var target = await GameManager.set_target()
	
	GameManager.actionBoxText.text="Rolling to heal"
	var healing=0
	
	if(target.champion):
		healing = (await GameManager.diceManager.roll_die(4))
	else:
		healing = (await GameManager.diceManager.roll_die(6))
	
	print(healing)
	
	GameManager.actionBoxText.text="Healed " + str(healing) + " health"
	
	if(target.health+healing<target.max_health):
		target.health+=healing
	else:
		GameManager.actionBoxText.text="Healed " + str(target.max_health-target.health) + " health"
		target.health=target.max_health
	
	GameManager.actionLine.visible=true
	GameManager.actionLine.points[1]=target.global_position
	GameManager.actionLine.points[1].y+=700
	GameManager.actionLine.points[1].x+=500
	
	await get_tree().create_timer(1.5).timeout
	GameManager.actionLine.visible=false
	GameManager.actionBox.visible=false
