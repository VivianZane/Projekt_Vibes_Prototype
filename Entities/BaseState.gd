extends Node
class_name BaseState

@onready var host = get_parent().get_parent()
var nextState:String = ""

func enter():
	pass

func exit():
	pass

func input(event: InputEvent) -> String:
	return ""

func process(delta: float) -> String:
	return ""

func physics_process(delta: float) -> String:
	return ""
