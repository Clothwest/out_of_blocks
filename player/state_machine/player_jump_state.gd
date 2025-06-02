class_name PlayerJumpState extends PlayerState

func enter() -> void:
	player.physics.apply_impulse_with_reset(player.jump_impulse, player.physics.Axis.Y)

func physics_update(_delta: float) -> void:
	# gravity
	if not player.is_on_floor():
		player.physics.apply_gravity()
	
	# x move
	var target_velocity_x: float = player.direction_x * player.max_x_speed
	var force_factor: float = player.air_acceleration_factor if player.direction_x != 0.0 else player.air_friction_factor
	var acceleration: Vector2 = Vector2((target_velocity_x - player.movement_velocity.x) * force_factor, 0.0)
	player.physics.apply_force(acceleration)
	
	transition()
