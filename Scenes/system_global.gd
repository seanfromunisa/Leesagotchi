extends Node

@export var totalSeconds: int = 0
@export var totalMinutes: int = 0
@export var totalHours: int = 0
@export var happiness: float = 80
@export var food: int = 0
@export var hunger: int = 100
@export var mergeItemNames: Array[String] = ["blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem", "blankItem"]
var globalHighlight: MergeItem = null
var windowHasFocus: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Check if save data exists. If so, load data
	var loadDataPath: String = "user://leesagotchisave.tres"
	if ResourceLoader.exists(loadDataPath):
		
		# TESTING
		print("LOADING")
		
		var savedGame: SavedGame = load(loadDataPath) as SavedGame
		
		totalSeconds = savedGame.totalSeconds
		totalMinutes = savedGame.totalMinutes
		totalHours = savedGame.totalHours
		happiness = savedGame.happiness
		hunger = savedGame.hunger
		food = savedGame.food
		mergeItemNames = savedGame.mergeItemNames

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Saving function, called each minute and on quit
func saveGame():
	
	# TESTING
	print("SAVING")
	
	var savedGame: SavedGame = SavedGame.new()
	
	savedGame.totalSeconds = totalSeconds
	savedGame.totalMinutes = totalMinutes
	savedGame.totalHours = totalHours
	savedGame.happiness = happiness
	savedGame.hunger = hunger
	savedGame.food = food
	savedGame.mergeItemNames = mergeItemNames
	
	ResourceSaver.save(savedGame, "user://leesagotchisave.tres")
