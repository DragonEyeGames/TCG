extends Sprite2D

@export var player1=true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(player1):
		Player1Manager.discardPile=self
	else:
		Player2Manager.discardPile=self
