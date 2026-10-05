extends Node2D
@export var mergeArray: Array[MergeItem] = [$mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1, $mergeItem1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Fills array of MergeItems, converting from BlankItems (need to add state loading)
	for arrayItem: MergeItem in mergeArray:
		changeArrayItem(arrayItem)

# Changes given MergeItem in array to a level 1/2 item
func changeArrayItem(item: MergeItem):
	
	# Checks if a pair not including itself exists in the array
	var pairFound: bool = false
	var index: int = 0
	
	# Will stop checking once a pair is found, or it has checked all items
	while (pairFound == false && index != 12):
		
		# The given item is about to change and must not check itself against other items
		if (mergeArray[index] != item):
			
			# Other items must also not check against the given item
			pairFound = checkOtherPairInArray(mergeArray[index], item)
			index += 1
		
	# Will change current MergeItem, ensuring a pair already exists or will now exist
	while (pairFound == false):
		pairFound = checkPairInArray(item.randItem())
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
