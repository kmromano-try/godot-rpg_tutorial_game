extends CharacterBody2D

var enemyAttackRange = false
var enemyAttackCD = true
var playerHealth = 100
var playerAlive = true
var playerAttackIP = false

const SPEED = 75
var current_dir = "none"


func _ready() -> void:
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta: float) -> void:
	
	if playerAttackIP == false:
		player_movement(delta)
	enemyAttack()
	updateHealth()
	playerAttack()
	
	if playerHealth <= 0:
		playerAlive = false
		playerHealth = 0
		print("GAME OVER")
		get_tree().reload_current_scene()

func  player_movement(_delta):
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
			#if playerAttackIP == false:
				anim.play("idle_side")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_side")
		else:
			#if playerAttackIP == false:
				anim.play("idle_side")
	
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_back")
		else:
			#if playerAttackIP == false:
				anim.play("idle_back")
	
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_front")
		else:
			#if playerAttackIP == false:
				anim.play("idle_front")

func playerAttack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		gloobal.playerCurrentAttack = true
		playerAttackIP = true
		if dir == "right":
			$AttackCooldown.start()
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack_side")
		elif dir == "left":
			$AttackCooldown.start()
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack_side")
		elif dir == "down":
			$AttackCooldown.start()
			$AnimatedSprite2D.play("attack_front")
		elif dir == "up":
			$AttackCooldown.start()
			$AnimatedSprite2D.play("attack_back")
	

func enemyAttack():
	if enemyAttackRange and enemyAttackCD:
		playerHealth = playerHealth - 10
		enemyAttackCD = false
		$AttackedCooldown.start()

func updateHealth():
	var healthbar = $HealthBar
	healthbar.value = playerHealth
	
	if playerHealth < 100:
		playerHealth += 0.1
	
	if playerHealth >= 100:
		playerHealth = 100
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_player_hit_box_body_entered(_body: Node2D) -> void:
	enemyAttackRange = true


func _on_player_hit_box_body_exited(_body: Node2D) -> void:
	enemyAttackRange = false


func _on_attacked_cooldown_timeout() -> void:
	$AttackedCooldown.stop()
	enemyAttackCD = true


func _on_attack_cooldown_timeout() -> void:
	$AttackCooldown.stop()
	playerAttackIP = false
	gloobal.playerCurrentAttack = false
