extends Node2D

func _process(delta: float) -> void:
	changeScene()

func changeScene():
	if gloobal.transitionScene == true:
		if gloobal.currentScene == "camp":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			gloobal.gameFirstLoading = false
			gloobal.finishChangeScene()

func _on_world_exit_body_entered(body: Node2D) -> void:
	gloobal.transitionScene = true
