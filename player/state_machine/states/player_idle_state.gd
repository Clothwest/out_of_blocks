class_name PlayerIdleState extends PlayerState

func enter() -> void:
	player.movement_velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	transition()
