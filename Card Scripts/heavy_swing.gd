extends Card

func onPlay():
	var strike = (await GameManager.diceManager.roll_die(20))
		
	var damage = (await GameManager.diceManager.roll_die(6))
	
	if(strike==20):
		damage += (await GameManager.diceManager.roll_die(6)) # Critical hit logic
	
	prints(strike, damage)
	return
