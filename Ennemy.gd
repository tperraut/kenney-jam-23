extends CharacterBody2D

class_name Enemy

@export var move_speed := 100

var target: Player = null

func _physics_process(delta):
	if target == null:
		return
	
	var motion := Vector2()
	look_at(target.position)
	motion = (target.position - position).normalized()
	move_and_collide(motion * move_speed * delta)


func _on_area_2d_body_entered(body):
	if body is Player and target == null:
		target = body
