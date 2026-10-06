extends "res://Scenes/main.gd"
var pettingSoot: bool = false
var timePettingSoot: int = 0
@onready var happinessLabel: Label = $happiness
@onready var hungerLabel: Label = $hunger
@onready var sootSprite: AnimatedSprite2D = $Soot/SootSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Update the emoji sprite based on happiness
	if (system_global.happiness <= 20):
		$Emoji.texture = load("res://Illustrations/emojiDead.png")
	elif (system_global.happiness > 20 && system_global.happiness <= 40):
		$Emoji.texture = load("res://Illustrations/emojiSad.png")
	elif (system_global.happiness > 40 && system_global.happiness < 60):
		$Emoji.texture = load("res://Illustrations/emojiMeh.png")
	elif (system_global.happiness >= 60 && system_global.happiness < 80):
		$Emoji.texture = load("res://Illustrations/emojiSmirk.png")
	else:
		$Emoji.texture = load("res://Illustrations/emojiHappy.png")
		
	# Update labels
	happinessLabel.text = str(int(system_global.happiness))
	hungerLabel.text = str(int(system_global.hunger))

# Pet soot sprite
func _on_soot_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		if (event.pressed):
			pettingSoot = true
			sootSprite.play("pet")
		else:
			pettingSoot = false
			sootSprite.play("idle")
			
# Tick function
func _on_timer_timeout() -> void:
	super()
	
	# If soot is being pet
	if (pettingSoot == true):
		
		# If they can be made happier
		if (system_global.happiness + 3 > 100):
			system_global.happiness = 100
		else:
			system_global.happiness += 3

# If the star is clicked, feed soot sprite
func _on_food_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			
			# Check if enough food
			if (system_global.food > 10):
				system_global.food -= 10
				sootSprite.play("eat")
				await get_tree().create_timer(5)
				sootSprite.play("idle")
				
				# If they have room for food
				if (system_global.hunger + 2 > 100):
					system_global.hunger = 100
				else: 
					system_global.hunger += 2
					
				# If they can be made happier
				if (system_global.happiness + 5 > 100):
					system_global.happiness = 100
				else:
					system_global.happiness += 5
