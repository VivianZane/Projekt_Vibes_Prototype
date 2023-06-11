extends Node

@onready var parent = get_parent()
var current_state: BaseState
var current_state_string:String
var previous_state_string: String
@onready var states = {}

func add_state(state_name: String):
	states[state_name] = get_node(state_name)

func change_state(new_state: String):
	previous_state_string = current_state_string
	if current_state:
		current_state.exit()

	current_state_string = new_state
	current_state = states[new_state]
	#print("previous: " + previous_state_string + " after: " + current_state_string)
	
	current_state.enter()
	
	

func init(stateList: PackedStringArray):
	for state_name in stateList:
		add_state(state_name)
	change_state(stateList[0])

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if states.has(new_state):
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if states.has(new_state):
		change_state(new_state)
