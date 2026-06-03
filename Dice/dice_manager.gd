extends Node3D

@export var D6: PackedScene
@export var D20: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.diceManager=self


func roll_die(sides: int):
	var die
	if(sides==6):
		die = D20.instantiate()
	if(sides==20):
		die = D20.instantiate()
	die.position=Vector3.ZERO
	die.position.y=.5
	add_child(die)
	die.roll_dice()
	while !die.isMoving:
		await get_tree().process_frame
	await get_tree().process_frame
	while die.isMoving:
		await get_tree().process_frame
	await get_tree().process_frame
	print(die.get_number())
	await get_tree().create_timer(1).timeout
	die.queue_free()
	return(die.get_number())
