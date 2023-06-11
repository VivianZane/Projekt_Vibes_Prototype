extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$Keyboard.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Back_pressed():
	hide()

func _on_CheckButton_toggled(button_pressed):
	if($Gamepad.visible == true):
		$Gamepad.visible = false
		$Keyboard.visible = true
	else:
		$Gamepad.visible = true
		$Keyboard.visible = false
