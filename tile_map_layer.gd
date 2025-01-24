@tool
extends TileMapLayer

# Use a Dictionary to store the tile data
# The key is the tile position as [x, y]
# var tiles = {}

# # Water tiles water value
# @export var max_water_value: int = 5

# func calculate_water_values():
# 	var used_rect = get_used_rect()
# 	var priority_queue = []
# 	var directions = [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]
	
# 	# Initialize the priority queue with all water tiles
# 	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
# 		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
# 			if tiles.has([x, y]) and tiles[[x, y]].is_water:
# 				tiles[[x, y]].water_value = max_water_value
# 				priority_queue.append([Vector2i(x, y), max_water_value])
	
# 	# Perform Dijkstra's algorithm to calculate water values
# 	while priority_queue.size() > 0:
# 		priority_queue.sort_custom(func(a, b): return b[1] > a[1])
# 		var current = priority_queue.pop_front()
# 		var current_pos = current[0]
# 		var current_value = current[1]

# 		# Check all 4 neighboring tiles
# 		for direction in directions:
# 			var neighbor_pos = current_pos + direction
# 			if tiles.has([neighbor_pos.x, neighbor_pos.y]):
# 				var neighbor_value = current_value - 1
# 				if neighbor_value > tiles[[neighbor_pos.x, neighbor_pos.y]].water_value:
# 					tiles[[neighbor_pos.x, neighbor_pos.y]].water_value = neighbor_value
# 					if neighbor_value > 0:
# 						priority_queue.append([neighbor_pos, neighbor_value])


func _on_timer_timeout() -> void:
	print("Received timeout signal!")
	notify_runtime_tile_data_update()
	
func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	print("Checking if tile data should be updated at ", coords)
	return true

func _update_tile_data(coords: Vector2i, tile_data: Dictionary) -> void:
	print("Updating tile data at ", coords)