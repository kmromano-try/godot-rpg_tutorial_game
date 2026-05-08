extends Node2D

func _ready() -> void:
	if gloobal.gameFirstLoading == true:
		$player.position.x = gloobal.playerStartPosX
		$player.position.y = gloobal.playerStartPosY
	else:
		$player.position.x = gloobal.playerExitPosX
		$player.position.y = gloobal.playerExitPosY

func _process(delta: float) -> void:
	changeScene()

func changeScene():
	if gloobal.transitionScene == true:
		if gloobal.currentScene == "world":
			get_tree().change_scene_to_file("res://scenes/camp.tscn")
			gloobal.gameFirstLoading = false
			gloobal.finishChangeScene()

func _on_camp_exit_body_entered(body: Node2D) -> void:
	gloobal.transitionScene = true
