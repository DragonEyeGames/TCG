extends Card

func onPlay():
	GameManager.actionBox.visible=true
	GameManager.actionBoxText.text="Pick your target"
	GameManager.targetParameters.clear()
	GameManager.targetParameters.append(GameManager.types.creature)
	var target = await GameManager.set_target()
	GameManager.targetParameters.clear()
	print(target.name)
	GameManager.actionBoxText.text="Rolling to hit"
	
	var strike = (await GameManager.diceManager.roll_die(20))
	
	if(Player1Manager.champion.inspirationLevel>0):
		GameManager.actionBoxText.text="Adding " + str(Player1Manager.champion.inspirationLevel) + " from inspiration"
		strike+=Player1Manager.champion.inspirationLevel
		await get_tree().create_timer(1.5).timeout
	
	GameManager.actionBoxText.text="Final value: " + str(strike)
	await get_tree().create_timer(1.5).timeout
	
	if strike==1:
		consumed=true
		print("FAILURE")
		GameManager.actionBoxText.text="Critical Miss!"
		await get_tree().create_timer(1).timeout
		GameManager.actionBox.visible=false
		SignalBus.emit_signal("strike", false, true)
		return
	
	if(strike<target.armor):
		GameManager.actionBoxText.text="Miss!"
		await get_tree().create_timer(1).timeout
		GameManager.actionBox.visible=false
		SignalBus.emit_signal("strike", false, true)
		return
	
	if(strike!=20):
		GameManager.actionBoxText.text="Hit"
	else:
		GameManager.actionBoxText.text="Critical Hit!"
	await get_tree().create_timer(1).timeout
	
	GameManager.actionBoxText.text="Rolling for damage"
	
	var damage = (await GameManager.diceManager.roll_die(6))
	
	if(strike==20):
		await get_tree().create_timer(.1).timeout
		damage += (await GameManager.diceManager.roll_die(6)) # Critical hit logic
	
	target.health-=damage
	
	GameManager.actionBoxText.text="Dealt " + str(damage) + " damage"
	
	prints(strike, damage)
	await get_tree().create_timer(1).timeout
	if(GameManager.actionBoxText.text=="Dealt " + str(damage) + " damage"):
		GameManager.actionBox.visible=false
	target.onDamage()
	SignalBus.emit_signal("strike", true, true)
	return
