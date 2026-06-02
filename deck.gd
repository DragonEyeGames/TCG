extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var original = $card
	for i in range (0, 19):
		var card=original.duplicate()
		add_child(card)
		card.position.y-=randi_range(6, 14)
		card.position.x=randi_range(-5, 5)
		original=card


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
