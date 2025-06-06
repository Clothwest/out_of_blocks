class_name PlayerJumpState extends PlayerState

# time
@export var min_jump_time: float = 0.15
@export var max_jump_time: float = 0.5
var jump_timer: float

# jump parameter
var jump_acceleration: Vector2
@export var jump_acceleration_magnitude: float = 500.0
@export var short_jump_cutoff_factor: float = 0.6

# hold
var can_hold: bool

func enter() -> void:
	can_hold = true
	jump_timer = 0.0
	player.is_in_jump_buffer_time = false
	player.is_in_coyote_time = false
	player.physics.apply_impulse_with_reset(player.jump_impulse, player.physics.Axis.Y)

func physics_update(delta: float) -> void:
	# jump
	if Input.is_action_pressed("jump") and can_hold:
		#if jump_timer > min_jump_time:
		jump_acceleration = -1 * player.physics.gravity_direction * jump_acceleration_magnitude
		player.physics.apply_force(jump_acceleration)
		
		# timer and condition
		jump_timer = move_toward(jump_timer, max_jump_time, delta)
		can_hold = false if jump_timer >= max_jump_time else true
	else:
		can_hold = false
		if Input.is_action_just_released("jump") and jump_timer < min_jump_time:
			player.movement_velocity.y *= short_jump_cutoff_factor
	
	# gravity
	if not player.is_on_floor():
		player.physics.apply_gravity()
	
	# x move
	var target_velocity_x: float = player.direction_x * player.max_x_speed
	var force_factor: float = player.air_acceleration_factor if player.direction_x != 0.0 else player.air_friction_factor
	var acceleration: Vector2 = Vector2((target_velocity_x - player.movement_velocity.x) * force_factor, 0.0)
	player.physics.apply_force(acceleration)
	
	transition()
