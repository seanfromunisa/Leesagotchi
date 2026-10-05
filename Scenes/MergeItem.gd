class_name MergeItem extends StaticBody2D

# List of all level 1 and 2 item names
var randItemList: Array[String] = ["Mango", "HJOrangeAndMango", "Controller", "Kart", "Chicken", "Hoverboard", "StumpySpark", "CarrySpark", "WhiteCapMushroom", "SkyrimDragon", "Carrot", "Leaves", "F1Tyre", "F1Helmet", "Paperclip", "FountainPen"]

# Each item starts as blank
var itemName: String = "BlankItem"
var highlighted: bool = false
var levelThree: bool = false

# Signals for merge successes, failures and collection
signal merge_success
signal merge_failure
signal merge_collect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.visible = false

# Change item name to one of the listed level 1/2 items
func randItem():
	itemName = randItemList[randi_range(0, 15)]
	
# Change the current item to the next level item
func merged():
	match itemName:
		"Mango": itemName = "HJOrangeAndMango"
		"HJOrangeAndMango":
			itemName = "MangoLoco"
			levelThree = true
		"Controller": itemName = "Kart"
		"Kart":
			itemName = "MushroomCup"
			levelThree = true
		"Chicken": itemName = "Hoverboard"
		"Hoverboard":
			itemName = "Delorean"
			levelThree = true
		"StumpySpark": itemName = "CarrySpark"
		"CarrySpark":
			itemName = "HaulingSpark"
			levelThree = true
		"WhiteCapMushroom": itemName = "SkyrimDragon"
		"SkyrimDragon":
			itemName = "SkyrimHelmet"
			levelThree = true
		"Carrot": itemName = "Leaves"
		"Leaves":
			itemName = "PickleRick"
			levelThree = true
		"F1Tyre": itemName = "F1Helmet"
		"F1Helmet":
			itemName = "LeClerc"
			levelThree = true
		"Paperclip": itemName = "FountainPen"
		"FountainPen":
			itemName = "Journal"
			levelThree = true
	
# Flips value of highlight sprite visibility and highlight boolean
func toggleHighlight():
	
	# If no item is highlighted, highlight self
	if (system_global.globalHighlight == null):
		system_global.globalHighlight = self
		highlighted = true
		$Sprite2D.visible = true
		
	# If any item, including self, is highlighted, unhighlight
	else:
		system_global.globalHighlight.highlighted = false
		system_global.globalHighlight.get_node("Sprite2D").visible = false
		system_global.globalHighlight = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TESTING
	pass
	# If item is not blank, therefore has a valid name, have its texture visible and current
	#if itemName != "BlankItem":
			#$Sprite2D3.texture = load("res://Illustrations/" + itemName + ".png")

# On-click event to select items and check for merges 
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			
			# TESTING
			print(itemName)
			
			# If the globally selected item is a different item, check that they are a match
			if (system_global.globalHighlight != null && system_global.globalHighlight != self):
				if (self.itemName == system_global.globalHighlight.itemName):
					self.merged()
					merge_success.emit()
				
				# If not a match, show failure
				else:
					merge_failure.emit()
				
				# Unhighlight currently highlighted item regardless
				toggleHighlight()
				
			# If item is level 3, change the item and collect the reward
			elif (levelThree):
				merge_collect.emit()
				
			# Clicking self below level 3 will toggle whether the item is highlighted
			else:
				toggleHighlight()
