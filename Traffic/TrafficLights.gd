extends Node2D

@onready var red: Node2D = $Red
@onready var yellow: Node2D = $Yellow
@onready var green: Node2D = $Green


@export var red_delay : float = 2.5
@export var yellow_delay : float = 0.5
@export var green_delay : float = 1.5
@export var yellow_flag : bool = true

enum Lights { RED, YELLOW, GREEN }


# current_light 변수의 값이 변경될 때 실행됨
var current_light : int = Lights.RED :
	set(light):
		current_light = light
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
	match color:
		Lights.RED:
			red.set_visible(true)
			yellow.set_visible(false)
			green.set_visible(false)
		Lights.YELLOW:
			red.set_visible(false)
			yellow.set_visible(true)
			green.set_visible(false)
		Lights.GREEN:
			red.set_visible(false)
			yellow.set_visible(false)
			green.set_visible(true)
