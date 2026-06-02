extends Node2D

@export var decklist: Array[GameManager.cards] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if(Input.is_action_just_pressed("Click")):
		draw_card()

func draw_card():
	if(len(decklist)<=0):
		return
	get_child(-1).queue_free()
	var cardName = GameManager.cards.keys()[decklist[0]]
	print(str(cardName))
	Player1Manager.draw_card(decklist[0])
	decklist.remove_at(0)
