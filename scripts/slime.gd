extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null
#tite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	player_chase = false
	animated_sprite_2d.play("idle_front")

func _physics_process(delta: float) -> void:
	if player_chase:
		print("CHASE")
		position += (player.position - position) / 50
		$AnimatedSprite2D.play("walk_side")
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		print("IDLE")
		$AnimatedSprite2D.play("idle_front")
	
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
	
