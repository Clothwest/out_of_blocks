class_name Player extends CharacterBody2D

const BALL = preload("res://ball/ball.tscn")

enum Sprite { DEFAULT, WITHOUT_BALL }

#region reference
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var physics: Physics = $Physics
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var throw: PlayerThrowState = %Throw

#endregion

#region direction
@export var initial_direction_x: float = 1.0
var direction_x: float:
	set(d):
		var threshold = 0.1
		direction_x = d if absf(d) > threshold else 0.0
		if direction_x != 0 and direction_x != last_direction_x:
			last_direction_x = direction_x
var last_direction_x: float

#endregion

#region movement parameter
# x
@export var max_x_speed: float = 300.0
#factor
@export_group("factor")
@export var ground_acceleretion_factor: float = 10.0
@export var ground_friction_factor: float = 10.0
@export var air_acceleration_factor: float = 10.0
@export var air_friction_factor: float = 1.0

@export_group("", "")

# y
@export var jump_impulse: Vector2 = Vector2(0.0, -450.0)

#endregion

#region ability
# dash
@export var dash_speed: float = 1000.0
@export var dash_duration: float = 0.3
var can_dash: bool = true
var is_dashing: bool = false

# throw
@export var throw_strength: float = 1000.0
@export var throw_recoil: float = 2000.0
var can_throw: bool = true
var ball_recalled: bool = true
var is_throwing: bool = false

# coyote jump
@export var coyote_time: float = 0.1
#var coyote_timer: float = 0.0
#var is_in_coyote_time: bool = false

#endregion

# velocity
var movement_velocity: Vector2:
	set(v):
		physics.velocity = v
	get():
		return physics.velocity

# external
var is_externally_affected: bool = false

func _ready() -> void:
	#coyote_timer = coyote_time
	direction_x = initial_direction_x
	movement_velocity = velocity
	
	physics.init()
	state_machine.init(self)

func update_animation() -> void:
	animated_sprite.frame = Sprite.DEFAULT if ball_recalled else Sprite.WITHOUT_BALL
	#state_machine.update_animation()

func _process(delta: float) -> void:
	state_machine.update(delta)

func _physics_process(delta: float) -> void:
	if not ball_recalled and throw.ball != null:
		if Input.is_action_pressed("recall_default") and not is_throwing:
			throw.ball.default_recall_start(self)
		elif Input.is_action_pressed("recall_navigation") and not is_throwing:
			throw.ball.navigation_recall_start(self)
		else:
			throw.ball.recall_end()
	direction_x = Input.get_axis("move_left", "move_right")
	state_machine.physics_update(delta)
	
	# animation
	update_animation()
	
	# actually move
	velocity = movement_velocity
	move_and_slide()
	movement_velocity = velocity
	
	# reset ability
	reset_abilities()

func reset_abilities() -> void:
	if not is_dashing and is_on_floor():
		can_dash = true
	if ball_recalled:
		can_throw = true
