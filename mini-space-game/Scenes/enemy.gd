extends Area2D
class_name Enemy

signal killed

@export var speed = 80
@export var hp = 10

func _process(delta: float) -> void:
	global_position.y += speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		hp -= area.damage
		if hp <= 0:
			killed.emit()
			queue_free()
		area.queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()


func _on_timer_timeout() -> void:
	queue_free()
