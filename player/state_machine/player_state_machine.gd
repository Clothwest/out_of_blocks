class_name PlayerStateMachine extends Node

#enum State { NULL = -1, IDLE, MOVE, JUMP, FALL, DASH, THROW }

@export var debug: bool = false

@export var initial_state: PlayerState
var current_state: PlayerState

var states: Dictionary = {}

func init(player: Player) -> void:
	for child in get_children():
		if child is PlayerState:
			child.player = player
			child.transition_requested.connect(_on_transition_request)
			states[child.state] = child
	if initial_state != null:
		change_state(initial_state)

func update_animation() -> void:
	if current_state != null:
		current_state.update_animation()

func update(delta: float) -> void:
	if current_state != null:
		current_state.update(delta) 

func physics_update(delta: float) -> void:
	if current_state != null:
		current_state.physics_update(delta)

func _on_transition_request(from: PlayerState, to: PlayerState.State) -> void:
	if from != current_state:
		return
	var target_state = states[to] if states.has(to) else null
	change_state(target_state)

func change_state(to: PlayerState) -> void:
	if current_state != null:
		current_state.exit()
	if to != null:
		to.enter()
		current_state = to
	if debug:
		print(current_state.name)
