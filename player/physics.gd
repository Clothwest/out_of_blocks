class_name Physics extends Node2D

enum Axis { X, Y, BOTH }

# default value
var default_gravity: Vector2 = Vector2(0, 1000.0)
var default_gravity_scale: float = 1.0

#region physics parameter
# gravity
var gravity: Vector2
var gravity_scale: float

# friction
var friction: Vector2
var friction_magnitude: float
var friction_direction: Vector2

#endregion

# actor's velocity
var velocity: Vector2

func init() -> void:
	gravity = default_gravity
	gravity_scale = default_gravity_scale

#region force
func apply_force(force: Vector2, delta: float = get_physics_process_delta_time()) -> void:
	velocity += force * delta

func apply_gravity(delta: float = get_physics_process_delta_time()) -> void:
	apply_force(gravity * gravity_scale, delta)

#endregion

#region impulse
func apply_impulse(impulse: Vector2) -> void:
	velocity += impulse

func apply_impulse_with_reset(impulse: Vector2, axis_to_reset: Axis = Axis.BOTH) -> void:
	set_velocity_to_zero(axis_to_reset)
	apply_impulse(impulse)

#endregion

#region velocity
func set_velocity(vel: Vector2) -> void:
	velocity = vel

func set_velocity_to_zero(axis: Axis = Axis.BOTH) -> void:
	if axis == Axis.X or axis == Axis.Y:
		velocity[axis] = 0.0
		return
	velocity = Vector2.ZERO

#endregion
