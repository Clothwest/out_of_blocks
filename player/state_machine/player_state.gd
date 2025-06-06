class_name PlayerState extends Node

signal transition_requested(from: PlayerState, to: State)

enum State { NULL = -1, IDLE, MOVE, JUMP, FALL, DASH, THROW }

@export var state: State = State.NULL
var player: Player

func enter() -> void: pass
func exit() -> void: pass
func update_animation() -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass

func get_target_state() -> State:
	
	if Input.is_action_just_pressed("dash") and player.can_dash:
		return State.DASH
	if Input.is_action_just_pressed("throw") and player.can_throw:
		return State.THROW
	if (player.is_on_floor() or player.is_in_coyote_time) and player.is_in_jump_buffer_time:
		return State.JUMP
	if player.direction_x != 0 and player.is_on_floor():
		return State.MOVE
	if player.direction_x == 0 and player.is_on_floor():
		return State.IDLE
	if not player.is_on_floor() and player.movement_velocity.y >= 0.0:
		return State.FALL
	#return State.FALL
	return State.NULL

func transition() -> void:
	var target_state: State = get_target_state()
	if target_state != State.NULL and target_state != state:
		transition_requested.emit(self, target_state)
