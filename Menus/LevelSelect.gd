extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	hide()


func _on_Tutorial_pressed():
	get_tree().change_scene_to_file("res://Levels/Tutorial/TutorialBack.tscn")


func _on_Level_1_pressed():
	get_tree().change_scene_to_file("res://Levels/Level 1/Level1.tscn")
