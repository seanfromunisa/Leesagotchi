extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
