@tool
extends TileMapLayer

# Water tiles water value
@export var max_water_value: int = 5

@onready var terrain_tile_map: TileMapLayer = $"../TerrainTileMap"

var water_values = {}

func _ready():
	if visible:
		update_water_values()

# Called when the visibility is toggled
func _on_visibility_toggled() -> void:
	if visible and terrain_tile_map != null:
		update_water_values()

# Called when a terrain tile is updated
func _on_terrain_tile_updated() -> void:
	# If visible, recalculate the water values
	if visible:
		update_water_values()

func update_water_values():
	clear()
	water_values.clear()

	var priority_queue = []
	
	# Initialize the priority queue with all water tiles
	for cell in terrain_tile_map.get_used_cells():
		# Get the tile data from the terrain tile map
		var terrain_tile_data = terrain_tile_map.get_cell_tile_data(cell)
		if terrain_tile_data != null and terrain_tile_data.get_custom_data("is_water"):
			water_values[cell] = max_water_value

			priority_queue.append([cell, max_water_value])
	
	# Perform Dijkstra's algorithm to calculate water values
	while priority_queue.size() > 0:
		priority_queue.sort_custom(func(a, b): return b[1] > a[1])
		var current = priority_queue.pop_front()
		var current_pos = current[0]
		var current_value = current[1]

		for neighbor_pos in terrain_tile_map.get_surrounding_cells(current_pos):
			var current_neighbor_value = water_values.get_or_add(neighbor_pos, 0)
			var neighbor_value = current_value - 1
			if neighbor_value > current_neighbor_value:
				water_values[neighbor_pos] = neighbor_value
				if neighbor_value > 0:
					priority_queue.append([neighbor_pos, neighbor_value])
	
	update_visuals()

func update_visuals():
	for cell in water_values.keys():
		# Determine the correct tile based on the water value
		var water_value = water_values[cell]
		var relative_value = float(water_value) / float(max_water_value)
		if relative_value == 1:
			set_cell(cell, 0, Vector2i(1, 0))
		elif relative_value >= 0.9:
			set_cell(cell, 0, Vector2i(1, 0), 90)
		elif relative_value >= 0.8:
			set_cell(cell, 0, Vector2i(1, 0), 80)
		elif relative_value >= 0.7:
			set_cell(cell, 0, Vector2i(1, 0), 70)
		elif relative_value >= 0.6:
			set_cell(cell, 0, Vector2i(1, 0), 60)
		elif relative_value >= 0.5:
			set_cell(cell, 0, Vector2i(1, 0), 50)
		elif relative_value >= 0.4:
			set_cell(cell, 0, Vector2i(1, 0), 40)
		elif relative_value >= 0.3:
			set_cell(cell, 0, Vector2i(1, 0), 30)
		elif relative_value >= 0.2:
			set_cell(cell, 0, Vector2i(1, 0), 20)
		elif relative_value >= 0.1:
			set_cell(cell, 0, Vector2i(1, 0), 10)
		else:
			set_cell(cell, 0, Vector2i(1, 0), 1)