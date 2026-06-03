extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false
	GameManager.actionBox=self
	GameManager.actionBoxText=$RichTextLabel
