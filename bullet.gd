extends RigidBody2D

class_name Bullet


func fire(position: Vector2, rotation: float, velocity: Vector2):
	self.position = position
	self.rotation = rotation
	self.apply_impulse(velocity, position)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	freeze = true
	if body is Enemy and !$BloodParticule.emitting:
		var p := $BloodParticule
		p.restart()
		$Sprite2D.visible = false
		await get_tree().create_timer(p.lifetime).timeout
		call_deferred("queue_free")
	else:
		call_deferred("queue_free")
