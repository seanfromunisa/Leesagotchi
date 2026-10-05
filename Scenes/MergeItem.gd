class_name MergeItem extends StaticBody2D
# List of all level 1 and 2 item names
var randItemList: Array[String] = ["Mango", "HJOrangeAndMango", "Controller", "Kart", "Chicken", "Hoverboard", "StumpySpark", "CarrySpark", "WhiteCapMushroom", "SkyrimDragon", "Carrot", "Leaves", "F1Tyre", "F1Helmet", "Paperclip", "FountainPen"]
# Each item starts as blank
var itemName = "BlankItem"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Change item name to one of the listed level 1/2 items
func randItem():
	itemName = randItemList[randi_range(0, 15)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# If item is not blank, therefore has a valid name, have its texture visible and current
	if itemName != "BlankItem":
			$Sprite2D3.texture = load("res://Illustrations/" + itemName + ".png")
