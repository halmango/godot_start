extends Node2D

@onready var red: Node2D = $Red
@onready var yellow: Node2D = $Yellow
@onready var green: Node2D = $Green


enum Lights { RED, YELLOW, GREEN }


var current_light : int = Lights.RED :
	set(value):
		current_light = value
		lights_on(current_light)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lights_on(current_light)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func lights_on(color : int) -> void:
	match color:
		Lights.RED:
			red.set_visible(true)
			yellow.set_visible(false)
			green.set_visible(false)
			await get_tree().create_timer(2.5).timeout
			current_light = Lights.GREEN
		Lights.YELLOW:
			red.set_visible(false)
			yellow.set_visible(true)
			green.set_visible(false)
			await get_tree().create_timer(1.5).timeout
			current_light = Lights.RED
		Lights.GREEN:
			red.set_visible(false)
			yellow.set_visible(false)
			green.set_visible(true)
			await get_tree().create_timer(0.5).timeout
			current_light = Lights.YELLOW
