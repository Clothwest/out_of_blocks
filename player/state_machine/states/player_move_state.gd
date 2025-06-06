class_name PlayerMoveState extends PlayerState

func physics_update(_delta: float) -> void:
	var target_velocity_x: float = player.direction_x * player.max_x_speed
	var force_factor: float = player.ground_acceleretion_factor if player.direction_x != 0.0 else player.ground_friction_factor
	var acceleration: Vector2 = Vector2((target_velocity_x - player.movement_velocity.x) * force_factor, 0.0)
	player.physics.apply_force(acceleration)
	
	transition()
