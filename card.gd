extends Control
class_name Card

@export var interactable=true
var followMouse=false
var placing=false
var hovered=false

@export var cardType: GameManager.cards
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func player1Cost(): #If we are player one make sure we can pay for the card
	return get_parent().get_parent().player1 and Player1Manager.actions>=GameManager.cardCosts[cardType]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(followMouse):
		global_position=get_global_mouse_position()-(pivot_offset*scale.x)
	if(placing and Input.is_action_just_pressed("Click")):
		if(Player1Manager.handOpen):
			var new = self.duplicate()
			Player1Manager.hand.get_node("CardHolder").add_child(new)
			queue_free()
		else:
			GameManager.play(cardType, self)
	if(Input.is_action_just_pressed("Click") and hovered and interactable and player1Cost()):
		var new = self.duplicate()
		new.interactable=false
		new.followMouse=true
		new.placing=true
		new.scale=Vector2(1.5, 1.5)
		new.global_position=get_global_mouse_position()-(pivot_offset*scale.x)
		get_parent().get_parent().get_parent().add_child(new)
		queue_free()


func _on_mouse_entered() -> void:
	#if(!interactable):
		#return
	hovered=true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), .1)
	z_index=1


func _on_mouse_exited() -> void:
	#if(!interactable):
		#return
	hovered=false
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), .1)
	z_index=0

func onPlay():
	print("empty on-play")
	return
