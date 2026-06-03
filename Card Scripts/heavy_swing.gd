extends Card

func onPlay():
	GameManager.diceManager.roll_die(6)
	print("triggered")
