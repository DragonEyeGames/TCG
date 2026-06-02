extends Node2D

var open=false;
@export var player1=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(player1):
		Player1Manager.hand=self
	else:
		Player2Manager.hand=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(!player1):
		return
	if(get_global_mouse_position().y>2100 and not open):
		open=true
		Player1Manager.handOpen=true
		$animator.play("open")
	elif(get_global_mouse_position().y<1000 and open):
		open=false
		$animator.play("close")
	Player1Manager.handOpen=open
