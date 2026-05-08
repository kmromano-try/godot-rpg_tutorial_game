extends Node

var currentScene = "world"
var transitionScene = false
var gameFirstLoading = true

var playerStartPosX = 160
var playerStartPosY = 73

var playerExitPosX = 12
var playerExitPosY = 77

func finishChangeScene():
	if transitionScene == true:
		transitionScene = false
		if currentScene == "world":
			currentScene = "camp"
		else:
			currentScene = "world"
