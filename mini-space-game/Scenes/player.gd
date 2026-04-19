extends CharacterBody2D
class_name Player

@export var speed = 300

var laser_scene : PackedScene = preload("res://Scenes/laser.tscn")

signal shot_laser(laser_scn : PackedScene)

func get_move_vector() -> Vector2:
	var x = Input.get_axis("move_left", "move_right")
	var y = Input.get_axis("move_up", "move_down")
	
	return Vector2(x, y)


func _process(delta: float) -> void:
	var move_vector = get_move_vector()
	var direction = move_vector.normalized()
	
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		shot_laser.emit(laser_scene)
