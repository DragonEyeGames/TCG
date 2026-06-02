extends Node2D

@export var player1=true
@export var decklist: Array[GameManager.cards] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(player1):
		Player1Manager.deck=self
	else:
		Player2Manager.deck=self
	var original = $card
	for i in range (0, len(decklist)-1):
		var card=original.duplicate()
		add_child(card)
		card.position.y-=randi_range(15, 22)
		card.position.x=randi_range(-10, 10)
		original=card
	decklist.shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Draw") and player1):
		draw_card()

func draw_card():
	if(len(decklist)<=0):
		return
	get_child(-1).queue_free()
	if(player1):
		Player1Manager.draw_card(decklist[0])
	else:
		Player2Manager.draw_card(decklist[0])
	decklist.remove_at(0)
