class_name Layers extends Node2D

@onready var blocks: TileMapLayer = $Blocks

var astar_grid: AStarGrid2D = AStarGrid2D.new()

func _ready() -> void:
	astar_grid.region = blocks.get_used_rect()
	astar_grid.cell_size = blocks.tile_set.tile_size
	astar_grid.update()
	update_ball_movable_area()

func find_path(from: Vector2i, to: Vector2i) -> Array[Vector2]:
	var path: Array[Vector2] = []
	for coordinate in astar_grid.get_id_path(from, to):
		path.append(map_to_global(coordinate))
	return path

func global_to_map(global_pos: Vector2) -> Vector2i:
	return blocks.local_to_map(to_local(global_pos))

func map_to_global(map_coordinate: Vector2i) -> Vector2:
	return to_global(blocks.map_to_local(map_coordinate))

func update_ball_movable_area() -> void:
	for cell in blocks.get_used_cells():
		astar_grid.set_point_solid(cell)
