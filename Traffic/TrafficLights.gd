extends Node2D
class_name TrafficLight

@onready var red: Node2D = $Red
@onready var yellow: Node2D = $Yellow
@onready var green: Node2D = $Green


@export var red_delay : float = 2.5
@export var yellow_delay : float = 0.5
@export var green_delay : float = 1.5
@export var yellow_flag : bool = true


signal LightsLog(prev: int, curr: int, node: Node2D)

enum Lights { RED, YELLOW, GREEN }

# current_light 변수의 값이 변경될 때 실행됨
var current_light : int = Lights.RED :
	set(light):
		var prev = current_light
		current_light = light
		var curr = current_light
		LightsLog.emit(prev, curr)
		set_light(current_light)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_light = Lights.RED
	lights_on()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func lights_on() -> void:
	await get_tree().create_timer(red_delay).timeout
	current_light = Lights.GREEN

	if yellow_flag == true:
		await get_tree().create_timer(yellow_delay).timeout
		current_light = Lights.YELLOW

	await get_tree().create_timer(green_delay).timeout
	current_light = Lights.RED
	
	lights_on()


func set_light(color: int) -> void:
	var my_tween : Tween = create_tween()
	var big: Vector2 = Vector2(1,1)
	var small: Vector2 = Vector2(0.4,0.4)
	
	my_tween.tween_property(red, "scale", small, 0.3).from_current()\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	my_tween.parallel().tween_property(yellow, "scale", small, 0.3).from_current()\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	my_tween.parallel().tween_property(green, "scale", small, 0.3).from_current()\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
			
	match color:
		Lights.RED:
			my_tween.tween_property(red, "scale", big, 0.3).from_current()\
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		Lights.YELLOW:
			my_tween.parallel().tween_property(yellow, "scale", big, 0.3).from_current()\
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		Lights.GREEN:
			my_tween.parallel().tween_property(green, "scale", big, 0.3).from_current()\
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
