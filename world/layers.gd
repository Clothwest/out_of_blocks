class_name Layers extends Node2D

@onready var blocks: TileMapLayer = $Blocks

var a_star_grid: AStarGrid2D = AStarGrid2D.new()

func _ready() -> void:
	a_star_grid.region = blocks.get_used_rect()
	a_star_grid.cell_size = blocks.tile_set.tile_size
	a_star_grid.update()
	update_ball_movable_area()

func update_ball_movable_area() -> void:
	for cell in blocks.get_used_cells():
		a_star_grid.set_point_solid(cell)
	a_star_grid.update()
