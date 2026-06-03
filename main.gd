extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.endTurn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Button.visible=!GameManager.targeting
	#if(GameManager.player1Turn and Player1Manager.actions==0 and not GameManager.swapping):
	#	GameManager.endTurn()
	#if(!GameManager.player1Turn and Player2Manager.actions==0 and not GameManager.swapping):
	#	GameManager.endTurn()


func voluntarySwap() -> void:
	if(GameManager.player1Turn and not GameManager.swapping):
		GameManager.endTurn()
