class_name PlayerThrowState extends PlayerState

enum CollisionMask { NULL = 0, BLOCK, PLAYER, BALL}

# ball
var ball: Ball

# thorw
var throw_time: float = 0.5
var throw_timer: float

func enter() -> void:
	# throw var
	player.can_throw = false
	player.ball_recalled = false
	throw_timer = 0.0
	player.is_throwing = true
	
	# throw
	throw()

func physics_update(delta: float)  -> void:
	if player.is_throwing:
		# movememt
		var impulse_factor: float = 0.1
		var impulse: Vector2 = Vector2(-1 * player.movement_velocity * impulse_factor)
		player.physics.apply_impulse(impulse)
		
		# throw
		throw_timer = move_toward(throw_timer, throw_time, delta)
		player.is_throwing = false if throw_timer >= throw_time else true
	else:
		transition()

func throw() -> void:
	# ball
	ball = player.BALL.instantiate()
	ball.pickup_box.set_collision_mask_value(CollisionMask.PLAYER, false)
	var throw_direction: Vector2 = (player.get_local_mouse_position()).normalized()
	var throw_velocity: Vector2 = throw_direction * player.throw_strength
	ball.set_initial_velocity(throw_velocity)
	ball.global_position = player.global_position
	player.get_parent().add_child(ball)
	# recoil
	player.physics.apply_impulse_with_reset(-1.0 * throw_direction * player.throw_recoil)
	
	# set mask
	await get_tree().create_timer(throw_time).timeout
	ball.pickup_box.set_collision_mask_value(CollisionMask.PLAYER, true)
