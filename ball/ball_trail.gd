class_name BallTrail extends Line2D

var max_point_count: int = 10

func _physics_process(delta: float) -> void:
	if get_point_count() < max_point_count:
		add_point(owner.global_position)
	else:
		remove_point(0)
