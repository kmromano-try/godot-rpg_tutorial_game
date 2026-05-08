extends Camera2D

#yes the whole camera script is AI

func _ready():
	# Wait for the scene to initialize
	call_deferred("setup_camera_from_ground_layer")

func setup_camera_from_ground_layer():
	# Looks for a node named "Ground" anywhere in the current scene
	var ground = get_tree().current_scene.find_child("ground", true, false)
	
	if ground is TileMapLayer:
		var map_rect = ground.get_used_rect()
		var cell_size = ground.tile_set.tile_size
		
		# Convert tile coordinates to pixel coordinates
		limit_left = map_rect.position.x * cell_size.x
		limit_top = map_rect.position.y * cell_size.y
		limit_right = map_rect.end.x * cell_size.x
		limit_bottom = map_rect.end.y * cell_size.y
		
		print("Camera limits updated to: ", limit_right, "x", limit_bottom)
	else:
		push_warning("Camera Warning: Could not find a TileMapLayer named 'Ground'")
