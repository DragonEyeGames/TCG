extends Node3D

@export var D4: PackedScene
@export var D6: PackedScene
@export var D20: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.diceManager=self


func roll_die(sides: int):
	var die
	if(sides==20):
		die = D20.instantiate() 
	elif sides == 6:
		die = D6.instantiate()
	elif sides == 4:
		die = D4.instantiate()

	add_child(die)
	die.position = Vector3(0, 0.0, 0)

	await get_tree().process_frame

	die.roll_dice()

	var number = await die.finished

	await get_tree().process_frame
	
	await get_tree().create_timer(1).timeout
	
	die.queue_free()

	return number
