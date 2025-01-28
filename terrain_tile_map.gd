@tool
extends TileMapLayer

# Signal to emit when a terrain tile is updated
signal terrain_tiles_updated()

# Store the previous state of the tile data for comparison
var previous_tile_data: Dictionary = {}

func _ready():
	if Engine.is_editor_hint():
		# Save the initial state of the tilemap data when loaded
		previous_tile_data = get_tile_data_snapshot()

func _process(_delta):
	if Engine.is_editor_hint():
		# Compare the current state with the previous state
		var current_tile_data = get_tile_data_snapshot()
		if current_tile_data != previous_tile_data:
			terrain_tiles_updated.emit()
			previous_tile_data = current_tile_data

# Utility to get a snapshot of the tile data
func get_tile_data_snapshot() -> Dictionary:
	var snapshot: Dictionary = {}
	for tile_position in get_used_cells():
		snapshot[tile_position] = get_cell_tile_data(tile_position)
	return snapshot