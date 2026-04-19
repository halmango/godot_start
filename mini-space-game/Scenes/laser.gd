extends Area2D
class_name Laser

@export var speed = 600
@export var level = 1
@export var damage = 1


var weapon_dic = {
	1: preload("res://Resources/laser1.tres"),
	2: preload("res://Resources/laser2.tres"),
	3: preload("res://Resources/laser3.tres"),
	4: preload("res://Resources/laser4.tres"),
	5: preload("res://Resources/laser5.tres"),
}
const LASER_1 = preload("res://Resources/laser1.tres")


func _ready() -> void:
	pass

func  _process(delta: float) -> void:
	global_position.y -= speed * delta


func load_weapon(lv : int) -> void:
	var weapon : LaserResource = weapon_dic[lv]
	level = weapon.level
	damage = weapon.damage
	$Sprite2D.texture = weapon.texture


func _on_timer_timeout() -> void:
	queue_free()
