extends CharacterBody2D

class_name Player

@export var move_speed := 200
@export var bullet_speed := 500
@export var bullet: Resource

var can_fire := true

func _physics_process(delta):
	# Add the gravity.
	var motion := Vector2()
	
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_right"):
		motion.x += 1

	look_at(get_global_mouse_position())
	
	motion = motion.normalized()
	velocity = motion * move_speed
	
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		fire()

func fire():
	#if !can_fire:
	#	return
	#can_fire = false
	var b: Bullet = bullet.instantiate()
	$Aim/MuzzleAnimation.play("Muzzle")
	b.fire($Aim.global_position, rotation, Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().root.call_deferred("add_child", b)
	$Sprite.frame = 1
	#$Timer.start()
	$FireChecker.start()


func _on_timer_timeout():
	$Sprite.frame = 0


func _on_fire_checker_timeout():
	can_fire = true
