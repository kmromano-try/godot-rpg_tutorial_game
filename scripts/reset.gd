extends Node


func _input(event):
	if event.is_action_pressed("reset"): # Default "Enter" or "Space"
		get_tree().reload_current_scene()
