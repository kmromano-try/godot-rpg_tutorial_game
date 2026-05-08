extends CharacterBody2D

const SPEED = 75
var current_dir = "none"


func _ready() -> void:
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta: float) -> void:
	player_movement(delta)


func  player_movement(delta):
	if Input.is_action_pressed("move_right"):
		play_anim(1)
		current_dir = "right"
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		play_anim(1)
		current_dir = "left"
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		play_anim(1)
		current_dir = "down"
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("move_up"):
		play_anim(1)
		current_dir = "up"
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_side")
		else:
			anim.play("idle_side")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_side")
		else:
			anim.play("idle_side")
	
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_back")
		else:
			anim.play("idle_back")
	
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_front")
		else:
			anim.play("idle_front")
