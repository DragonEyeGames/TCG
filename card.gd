extends Control
class_name Card

@export var interactable=true
@export var display=false
var followMouse=false
var placing=false
var hovered=false

@export var creature=false

@export var champion=false

@export var armor: int
@export var health: int
var max_health: int

@export var cardType: GameManager.cards

var consumed=false

var onField=false
var player1=false

@export var inspirationLevel:=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_health=health
	SignalBus.strike.connect(onStrike)
	if("field" in str(get_parent().name).to_lower()):
		print("Field")
		onField=true
		print(name)
		if("1" in str(get_parent().name)):
			player1=true
		else:
			player1=false
		
		if(player1):
			Player1Manager.active.append(self)
		else:
			Player2Manager.active.append(self)
	if(champion):
		$"Status Counters".visible=true
		for child in $"Status Counters".get_children():
			child.visible=false
		if(player1):
			Player1Manager.champion=self
		else:
			Player2Manager.champion=self

func player1Cost(): #If we are player one make sure we can pay for the card
	return get_parent().get_parent().player1 and Player1Manager.actions>=GameManager.cardCosts[cardType]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(champion and inspirationLevel!=0):
		$"Status Counters/Inspired".visible=true
		if(inspirationLevel!=1):
			$"Status Counters/Inspired/RichTextLabel".text=str(inspirationLevel)
		else:
			$"Status Counters/Inspired/RichTextLabel".text=""
	elif champion:
		$"Status Counters/Inspired".visible=false
	if(!display and hovered and Input.is_action_just_pressed("Expand")):
		GameManager.zoom.display(self)
	if creature:
		$Armor/Count.text=str(armor)
		$Health/Count.text=str(health)
	if(GameManager.targeting):
		if(Input.is_action_just_pressed("Click") and hovered and not display):
			GameManager.potentialTarget=self
		return
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
	if(display):
		return
	hovered=true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), .1)
	z_index=1


func _on_mouse_exited() -> void:
	if(display):
		return
	hovered=false
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), .1)
	z_index=0

func onPlay():
	print("empty on-play")
	return
	
func onStrike(success: bool, _player: bool):
	if(!onField):
		return
	if(success):
		successfulStrike()
	else:
		failedStrike()
		
func successfulStrike():
	pass
	
func failedStrike():
	pass

func onDamage():
	pass
