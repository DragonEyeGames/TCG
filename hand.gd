extends Node2D

var open=false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player1Manager.hand=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(get_global_mouse_position().y>2500 and not open):
		open=true
		$animator.play("open")
	elif(get_global_mouse_position().y<1000 and open):
		open=false
		$animator.play("close")
