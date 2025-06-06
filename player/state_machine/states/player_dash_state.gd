class_name PlayerDashState extends PlayerState

var dash_timer: float

func enter() -> void:
	# dash var
	dash_timer = 0.0
	player.is_dashing = true
	player.can_dash = false
	
	# velocity
	var dash_velocity: Vector2 = Vector2(player.last_direction_x * player.dash_speed, 0)
	player.movement_velocity = dash_velocity

func physics_update(delta: float) -> void:
	if player.is_dashing:
		dash_timer = move_toward(dash_timer, player.dash_duration, delta)
		player.is_dashing = false if dash_timer >= player.dash_duration else true
	else:
		transition()

func exit() -> void:
	player.movement_velocity = Vector2.ZERO
	player.is_dashing = false
