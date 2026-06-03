extends Node3D

@export var D6: PackedScene
@export var D20: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.diceManager=self


func roll_die(sides: int):
	var die = D20.instantiate() if sides == 20 else D6.instantiate()

	add_child(die)
	die.global_position = Vector3(0, 0.5, 0)

	die.roll_dice()

	var number = await die.finished

	await get_tree().process_frame
	
	await get_tree().create_timer(1).timeout
	
	die.queue_free()

	return number
