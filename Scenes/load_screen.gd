extends "res://Scenes/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	# If the 7th, show special screen
	var current_time: Dictionary = Time.get_datetime_dict_from_system()
	if (current_time["day"] == 7):
		$Loadscreen.texture = load("res://Illustrations/monthiversary.png")
	else:
		$Loadscreen.texture = load("res://Illustrations/loading.png")
		
	# Wait 2 seconds before changing to tamagotchi screen
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/tamagotchiScreen.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
