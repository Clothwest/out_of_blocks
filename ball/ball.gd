class_name Ball extends CharacterBody2D

@onready var physics: Physics = $Physics

@export var pickup_box: Area2D

var initial_velocity: Vector2 = Vector2(0.0, -300.0)

var movement_velocity: Vector2:
	set(v):
		physics.velocity = v
	get():
		return physics.velocity

func set_initial_velocity(vel: Vector2 = initial_velocity) -> void:
	initial_velocity = vel

func _ready() -> void:
	movement_velocity = initial_velocity
	
	physics.init()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		physics.apply_gravity()
	
	# actually move
	velocity = movement_velocity
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision != null:
		var normal: Vector2 = collision.get_normal()
		var remainder: Vector2 = collision.get_remainder()
		move_and_collide(remainder.bounce(normal))
		velocity = velocity.bounce(normal)
		movement_velocity = velocity

func _on_pickup_box_body_entered(body: Node2D) -> void:
	if body is Player:
		body.ball_recalled = true
		queue_free()
