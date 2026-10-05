extends Node2D

# Array of all on-screen MergeItem objects
@onready var mergeArray: Array[MergeItem] = [get_node("mergeItem1"), get_node("mergeItem2"), get_node("mergeItem3"), get_node("mergeItem4"), get_node("mergeItem5"), get_node("mergeItem6"), get_node("mergeItem7"), get_node("mergeItem8"), get_node("mergeItem9"), get_node("mergeItem10"), get_node("mergeItem11"), get_node("mergeItem12")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Connect to MergeItems signals
	for item in mergeArray:
		item.connect("merge_success", mergeSuccess)
		item.connect("merge_failure", mergeFailure)
		item.connect("merge_collect", mergeCollect.bind(item))
	
	# Fills array of MergeItems, converting from BlankItems (need to add state loading)
	for arrayItem: MergeItem in mergeArray:
		changeArrayItem(arrayItem)

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
			
			# TESTING
			if (pairFound == true):
				print("merge possible")
		
		# Index integer increases
		index += 1
		
	# Will change current MergeItem, ensuring a pair already exists or will now exist, running at least once
	var firstRun = false
	while (firstRun == false || pairFound == false):
		item.randItem()
		
		# Only if pair is found, update pairFound to true, regardless of if it already was
		if (checkPairInArray(item)):
			pairFound = true
		
		# TESTING
		print("did change: " + item.itemName)
		
		# After running at least once, if a pair is found/already found, continue. otherwise, repeat
		firstRun = true
	
	# TESTING
	if (index == 12):
		print("merge made possible")
	
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
	
# Visible acknowledgement for successful merge, before changing globally highlighted item
func mergeSuccess():
	# TESTING
	changeArrayItem(system_global.globalHighlight)
	print("merge success!!")

# Visible acknowledgement for failed merge	
func mergeFailure():
	# TESTING
	print("merge failed...")
	
# Visible acknowledgement for successful collection, and added food value
func mergeCollect(item: MergeItem):
	# TESTING
	print("collected " + item.itemName + "!")
	print("merge collect! +3")
	
	# Collect food and change the successfully collected item
	system_global.food += 3
	if (system_global.food > 99999):
		system_global.food = 99999
	changeArrayItem(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
