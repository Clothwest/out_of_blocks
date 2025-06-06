class_name Physics extends Node

enum Axis { X, Y, BOTH }

# default value
const DEFAULT_GRAVITY: Vector2 = DEFAULT_GRAVITY_DIRECTION * DEFAULT_GRAVITY_MAGNITUDE
const DEFAULT_GRAVITY_DIRECTION: Vector2 = Vector2.DOWN
const DEFAULT_GRAVITY_MAGNITUDE: float = 1000.0
const DEFAULT_GRAVITY_SCALE: float = 1.0

#region physics parameter
# gravity
var gravity: Vector2
var gravity_direction: Vector2
var gravity_magnition: float
var gravity_scale: float

# friction
var friction: Vector2
var friction_magnitude: float
var friction_direction: Vector2

#endregion

# actor's velocity
var velocity: Vector2

func init() -> void:
	gravity = DEFAULT_GRAVITY
	gravity_direction = DEFAULT_GRAVITY_DIRECTION
	gravity_magnition = DEFAULT_GRAVITY_MAGNITUDE
	gravity_scale = DEFAULT_GRAVITY_SCALE

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
