extends Control

func _ready():
	pass 

func _process(delta):
	if get_tree().paused:
		hide()
	else: 
		show()
