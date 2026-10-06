extends Node2D
@onready var timer: Timer = $Tick
@onready var lostFocusFilter: Sprite2D = $lostFocusFilter

# Start the tick timer on each scene
func _ready() -> void:
	timer.start(1)
	lostFocusFilter.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Tick function
func _on_timer_timeout() -> void:
	var rateDueToFocus: int = 1
	if (system_global.windowHasFocus == false):
		rateDueToFocus = 2
	
	# Add second to total time and restart timer
	system_global.totalSeconds += 1
	if (system_global.totalSeconds == 60):
		system_global.totalSeconds = 0
		system_global.totalMinutes += 1
		
		# TESTING
		print("REACHED SAVE")
		
		# Save game each minute
		system_global.saveGame()
		
		if (system_global.totalMinutes == 60):
			system_global.totalMinutes = 0
			system_global.totalHours += 1
	
	timer.start(1)
	
	# Happiness and hunger decrease over time
	if (system_global.totalSeconds % (15 * rateDueToFocus) == 0):
		var hungerRate: float = (200 - system_global.hunger) / 100
		var hungerInducedUnhappiness: float = 1 * hungerRate
		if (system_global.happiness - hungerInducedUnhappiness < 1):
			system_global.happiness = 1
		else:
			system_global.happiness -= hungerInducedUnhappiness
		
	if (system_global.totalSeconds % (10 * rateDueToFocus) == 0 && system_global.hunger != 0):
		if (system_global.hunger - 1 < 1):
			system_global.hunger = 1
		else:
			system_global.hunger -= 1
		
	# TESTING
	print("happiness:")
	print(system_global.happiness)
	print("hunger:")
	print(system_global.hunger)
		
# On quit (ideally), save the game data
func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		system_global.windowHasFocus = false
		lostFocusFilter.visible = true
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		system_global.windowHasFocus = true
		lostFocusFilter.visible = false
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		system_global.saveGame()

# On click event, switching to tamagotchi screen
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if scene_file_path != "res://Scenes/tamagotchiScreen.tscn":
		if (event is InputEventMouseButton and event.pressed):
			if (event.button_index == MOUSE_BUTTON_LEFT):
				get_tree().change_scene_to_file("res://Scenes/tamagotchiScreen.tscn")

# On click event, switching to merge screen
func _on_area_2d_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if scene_file_path != "res://Scenes/mergeScreen.tscn":
		if (event is InputEventMouseButton and event.pressed):
			if (event.button_index == MOUSE_BUTTON_LEFT):
				get_tree().change_scene_to_file("res://Scenes/mergeScreen.tscn")

# On click event, switching to stats screen
func _on_area_2d_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if scene_file_path != "res://Scenes/statScreen.tscn":
		if (event is InputEventMouseButton and event.pressed):
			if (event.button_index == MOUSE_BUTTON_LEFT):
				get_tree().change_scene_to_file("res://Scenes/statScreen.tscn")
