extends CharacterBody2D

var speed = 50
var health = 50
var canBeDamage = true

var player_chase = false
var player = null

var attackRange = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	player_chase = false
	animated_sprite_2d.play("idle_front")

func _physics_process(delta: float) -> void:
	dealDamage()
	
	if player_chase and is_instance_valid(player):
		# 1. Calculate direction (Target - Self)
		var direction = (player.position - position).normalized()
		
		# 2. Set velocity instead of changing position directly
		velocity = direction * speed
		
		# Animation Logic
		animated_sprite_2d.play("walk_side")
		animated_sprite_2d.flip_h = direction.x < 0
	else:
		# 3. Stop moving when not chasing
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		animated_sprite_2d.play("idle_front")
	
	# 4. This actually applies the movement and handles collisions
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
	

func dealDamage():
	if gloobal.playerCurrentAttack and attackRange:
		if canBeDamage:
			health = health - 20
			canBeDamage = false
			$IFrame.start()
			print(health)
			
			if health <= 0:
				print("Slime died")
				self.queue_free()

func _on_slime_attack_range_body_entered(body: Node2D) -> void:
	player = body
	attackRange = true
	


func _on_slime_attack_range_body_exited(body: Node2D) -> void:
	player = body
	attackRange = false


func _on_i_frame_timeout() -> void:
	$IFrame.stop()
	canBeDamage = true
