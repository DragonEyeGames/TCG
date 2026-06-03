extends Card

func onPlay():
	GameManager.actionBox.visible=true
	GameManager.actionBoxText.text="Pick your target"
	var target = await GameManager.set_target()
	print(target.name)
	GameManager.actionBoxText.text="Rolling to hit"
	
	var strike = (await GameManager.diceManager.roll_die(20))
	strike=19
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
	await get_tree().create_timer(.5).timeout
	
	GameManager.actionBoxText.text="Rolling for damage"
	
	var damage = (await GameManager.diceManager.roll_die(6))
	
	if(strike==20):
		await get_tree().create_timer(.1).timeout
		damage += (await GameManager.diceManager.roll_die(6)) # Critical hit logic
	
	target.health-=damage
	
	GameManager.actionBoxText.text="Dealt " + str(damage) + " damage"
	
	prints(strike, damage)
	await get_tree().create_timer(1).timeout
	GameManager.actionBox.visible=false
	SignalBus.emit_signal("strike", true, true)
	return
