extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	awaitUse()

func awaitUse():
	visible=false
	$Line2D.visible=false
	while GameManager.potentialTarget==null:
		await get_tree().process_frame
	visible=true
	var card = GameManager.potentialTarget.duplicate()
	var points = $Line2D.points
	$Line2D.visible=true
	points[1]=to_local(GameManager.potentialTarget.global_position)
	points[1].y+=700
	$Line2D.points=points
	card.display=true
	card.scale=Vector2(2.3, 2.3)
	card.position=Vector2(2810, -427)
	add_child(card)
	while GameManager.potentialTarget!=null or visible:
		await get_tree().process_frame
	card.queue_free()
	visible=false
	awaitUse()

func _on_yes_pressed() -> void:
	GameManager.target=GameManager.potentialTarget
	visible=false


func _on_no_pressed() -> void:
	GameManager.potentialTarget=null
	visible=false
