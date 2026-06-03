extends RigidBody3D

@export var max_random_force: float = 0 # Reduced slightly for better control
@export var jump_force: float = 0          # Lifts the die off the ground slightly

@onready var faces = $Faces
var isMoving: bool = false
var isFinished: bool = false

signal finished(result)

func _ready() -> void:
	$Number.visible=false
	# Godot 4 automatically randomizes on startup, but we randomize orientation here:
	rotation_degrees = Vector3(
		randf_range(0, 360),
		randf_range(0, 360),
		randf_range(0, 360)
	)

func _physics_process(_delta: float) -> void:
	# Include angular velocity so we know it's fully stopped spinning too
	if(isMoving):
		isMoving = linear_velocity.length() > 0.02 or angular_velocity.length() > 0.02
		if(!isMoving):
			await get_tree().create_timer(.25).timeout
			isFinished=true
			$Number.visible=true
			emit_signal("finished", get_number())
	else:
		isMoving = linear_velocity.length() > 0.02 or angular_velocity.length() > 0.02
	$Number.text=str(get_number())

func get_number() -> int:
	var lowest_y: float = INF
	var number: String = ""
	
	for node in faces.get_children():
		var y_value = node.global_position.y
		if y_value < lowest_y:
			lowest_y = y_value
			number = node.name
			
	return int(str(number))

func roll_dice() -> void:
	#if isMoving: 
	#	return
		
	# Ensure the die is awake so physics can act on it
	sleeping = false
	
	var rng = RandomNumberGenerator.new()
	var random_direction = [-1, 1]
	
	# 1. Create a chaotic rotational impulse (Torque Impulse)
	var torque_impulse = Vector3(
		rng.randf_range(5.0, max_random_force) * random_direction.pick_random(),
		rng.randf_range(5.0, max_random_force) * random_direction.pick_random(),
		rng.randf_range(5.0, max_random_force) * random_direction.pick_random()
	)
	
	# 2. Create a slight linear upward/forward push so it hops
	var linear_impulse = Vector3(
		rng.randf_range(-2.0, 2.0),
		jump_force,
		rng.randf_range(-2.0, 2.0)
	)
	
	# 3. Apply impulses (These work beautifully with Jolt)
	apply_torque_impulse(torque_impulse)
	apply_central_impulse(linear_impulse)
