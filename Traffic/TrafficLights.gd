extends Node2D

@onready var red: Node2D = $Red
@onready var yellow: Node2D = $Yellow
@onready var green: Node2D = $Green

@onready var red_2: Node2D = $Red2
@onready var yellow_2: Node2D = $Yellow2
@onready var green_2: Node2D = $Green2

@onready var red_3: Node2D = $Red3
@onready var yellow_3: Node2D = $Yellow3
@onready var green_3: Node2D = $Green3


@export var red_delay : float = 2.5
@export var yellow_delay : float = 0.5
@export var green_delay : float = 1.5

@export var red_delay2 : float = 1.0
@export var green_delay2 : float = 1.0

@export var red_delay3 : float = 3.3
@export var yellow_delay3 : float = 0.7
@export var green_delay3 : float = 1.5


enum Lights { RED, YELLOW, GREEN }

var current_light_delay : float = red_delay
# current_light 변수의 값이 변경될 때 실행됨
var current_light : int = Lights.RED :
	set(light):
		current_light = light
		lights_on(current_light)


var current_light2 : int = Lights.RED :
	set(light):
		current_light2 = light
		second_lights_on(current_light2)


var current_light3 : int = Lights.RED:
	set(light):
		current_light3 = light
		third_lights_on(current_light3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lights_on(current_light)
	second_lights_on(current_light2)
	third_lights_on(current_light3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func lights_on(color : int) -> void:
	match color:
		Lights.RED:
			red.set_visible(true)
			yellow.set_visible(false)
			green.set_visible(false)
			await get_tree().create_timer(red_delay).timeout
			current_light = Lights.GREEN
		Lights.YELLOW:
			red.set_visible(false)
			yellow.set_visible(true)
			green.set_visible(false)
			await get_tree().create_timer(yellow_delay).timeout
			current_light = Lights.RED
		Lights.GREEN:
			red.set_visible(false)
			yellow.set_visible(false)
			green.set_visible(true)
			await get_tree().create_timer(green_delay).timeout
			current_light = Lights.YELLOW


func second_lights_on(color : int) -> void:
	match color:
		Lights.RED:
			red_2.set_visible(true)
			yellow_2.set_visible(false)
			green_2.set_visible(false)
			await get_tree().create_timer(red_delay2).timeout
			current_light2 = Lights.GREEN
		Lights.GREEN:
			red_2.set_visible(false)
			yellow_2.set_visible(false)
			green_2.set_visible(true)
			await get_tree().create_timer(green_delay2).timeout
			current_light2 = Lights.RED


func third_lights_on(color : int) -> void:
	match color:
		Lights.RED:
			red_3.set_visible(true)
			yellow_3.set_visible(false)
			green_3.set_visible(false)
			await get_tree().create_timer(red_delay3).timeout
			current_light3 = Lights.GREEN
		Lights.YELLOW:
			red_3.set_visible(false)
			yellow_3.set_visible(true)
			green_3.set_visible(false)
			await get_tree().create_timer(yellow_delay3).timeout
			current_light3 = Lights.RED
		Lights.GREEN:
			red_3.set_visible(false)
			yellow_3.set_visible(false)
			green_3.set_visible(true)
			await get_tree().create_timer(green_delay3).timeout
			current_light3 = Lights.YELLOW
