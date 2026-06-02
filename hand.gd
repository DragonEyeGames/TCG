extends Node2D

var open=true;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(get_global_mouse_position().y>850 and not open):
		open=true
		$animator.play("open")
	elif(get_global_mouse_position().y<850 and open):
		open=false
		$animator.play("close")
