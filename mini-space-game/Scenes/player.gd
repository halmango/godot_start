extends CharacterBody2D

@export var speed = 300

func get_move_vector() -> Vector2:
	var x = Input.get_axis("move_left", "move_right")
	var y = Input.get_axis("move_up", "move_down")
	
	return Vector2(x, y)


func _process(delta: float) -> void:
	var move_vector = get_move_vector()
	var direction = move_vector.normalized()
	
	velocity = direction * speed
	move_and_slide()
