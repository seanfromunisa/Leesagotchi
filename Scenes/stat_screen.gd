extends "res://Scenes/main.gd"
@onready var time: Label = $time
@onready var happy: Label = $happy
@onready var merge: Label = $merge
@onready var food: Label = $food

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Update labels each frame
func _process(delta: float) -> void:
	
	# Update time label, maxing out at over 99 hours
	if (system_global.totalHours > 99):
		time.text = "99h 59m"
	else:
		time.text = str(system_global.totalHours) + "h " + str(system_global.totalMinutes) + "m"
		
	# Update happy, merge, and food
	happy.text = str(system_global.happyPointsGot)
	merge.text = str(system_global.itemsMerged)
	food.text = str(system_global.food)
