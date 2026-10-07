extends "res://Scenes/main.gd"

# Array of all on-screen MergeItem objects
@onready var mergeArray: Array[MergeItem] = [get_node("mergeItem1"), get_node("mergeItem2"),get_node("mergeItem3"), get_node("mergeItem4"), get_node("mergeItem5"), get_node("mergeItem6"), get_node("mergeItem7"), get_node("mergeItem8"), get_node("mergeItem9"), get_node("mergeItem10"), get_node("mergeItem11"), get_node("mergeItem12")]
@onready var screenAnims: AnimatedSprite2D = $screenAnims

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	# Connect to MergeItems signals
	for item in mergeArray:
		item.connect("merge_success", mergeSuccess)
		item.connect("merge_failure", mergeFailure)
		item.connect("merge_collect", mergeCollect.bind(item))
	
	# Check if there are items to load from global array
	if (system_global.mergeItemNames[0] == "blankItem"):
		
		# Fills array of MergeItems, converting from BlankItems (need to add state loading)
		for arrayItem: MergeItem in mergeArray:
			changeArrayItem(arrayItem)
	
	# Otherwise, load items in
	else:
		for index in mergeArray.size():
			var name: String = system_global.mergeItemNames[index]
			mergeArray[index].itemName = name
			
			# If it's a level 3 item, label as such
			if (name == "MangoLoco" || name == "MushroomCup" || name == "Delorean" || name == "HaulingSpark" || name == "SkyrimHelmet" || name == "PickleRick" || name == "LeClerc" || name == "Journal"):
				mergeArray[index].levelThree = true

# Changes given MergeItem in array to a level 1/2 item
func changeArrayItem(item: MergeItem):
	
	# As a level 1/2 item, the LevelThree boolean is false
	item.levelThree = false
	
	# Checks if a pair not including itself exists in the array
	var pairFound: bool = false
	var index: int = 0
	
	# Will stop checking once a pair is found, or it has checked all items
	while (pairFound == false && index != 12):
		
		# The given item is about to change and must not check itself against other items
		if (mergeArray[index] != item):
			
			# Other items must also not check against the given item
			pairFound = checkOtherPairInArray(mergeArray[index], item)
		
		# Index integer increases
		index += 1
		
	# Will change current MergeItem, ensuring a pair already exists or will now exist, running at least once
	var firstRun = false
	while (firstRun == false || pairFound == false):
		item.randItem()
		
		# Only if pair is found, update pairFound to true, regardless of if it already was
		if (checkPairInArray(item)):
			pairFound = true
		
		# After running at least once, if a pair is found/already found, continue. otherwise, repeat
		firstRun = true
	
	# Save array to global variable
	system_global.mergeItemNames = [$mergeItem1.itemName, $mergeItem2.itemName, $mergeItem3.itemName, $mergeItem4.itemName, $mergeItem5.itemName, $mergeItem6.itemName, $mergeItem7.itemName, $mergeItem8.itemName, $mergeItem9.itemName, $mergeItem10.itemName, $mergeItem11.itemName, $mergeItem12.itemName]
	
# Checks if any array items match the given item
func checkPairInArray(item: MergeItem):
	for arrayItem: MergeItem in mergeArray:
		
		# Checks if they have the same name and aren't the same instance
		if (item.itemName == arrayItem.itemName && arrayItem != item):
			return true
	return false
	
# Checks the same, absent a second given item
func checkOtherPairInArray(item: MergeItem, excluded: MergeItem):
	for arrayItem: MergeItem in mergeArray:
		
		# Checks if given item is a name match to a different item that is not the excluded item
		if (item.itemName == arrayItem.itemName && arrayItem != item && arrayItem != excluded):
			return true
	return false
	
# Change globally highlighted item
func mergeSuccess():
	changeArrayItem(system_global.globalHighlight)
	
	# Add to items merged count
	if (system_global.itemsMerged + 1 > 999999):
		system_global.itemsMerged = 999999
	else:
		system_global.itemsMerged += 1

# Visible acknowledgement for failed merge	
func mergeFailure():
	
	# Play failure animation
	screenAnims.play("wrong")
	await get_tree().create_timer(1).timeout
	screenAnims.play("none")
	
# Visible acknowledgement for successful collection, and added food value
func mergeCollect(item: MergeItem):
	
	# Collect food and change the successfully collected item
	system_global.food += 3
	if (system_global.food > 99999):
		system_global.food = 99999
	changeArrayItem(item)
	
	# Play collection animation
	screenAnims.play("collect")
	await get_tree().create_timer(1).timeout
	screenAnims.play("none")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
