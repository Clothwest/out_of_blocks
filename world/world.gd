class_name World extends Node2D

@onready var layers: Layers = $Layers
@onready var player: Player = $Player

func _ready() -> void:
	player.ball_throwed.connect(_on_player_ball_throwed)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_player_ball_throwed(ball: Ball) -> void:
	ball.navigation_recall_started.connect(_on_ball_navigation_recall_started)

func _on_ball_navigation_recall_started() -> void:
	pass
