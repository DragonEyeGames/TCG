extends Node2D

var new
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.zoom=self
	visible=false


func display(card: Control):
	#Player1Manager.hand_lock=true
	if(new!=null):
		new.queue_free()
	visible=true
	new = card.duplicate()
	new.display=true
	new.scale=Vector2(3, 3)
	add_child(new)
	new.global_position=Vector2(-4900, -2200)

func _process(_delta: float) -> void:
	if(visible and Input.is_action_just_pressed("Click")):
		visible=false
		if(new!=null):
			new.queue_free()
		#Player1Manager.hand_lock=false
