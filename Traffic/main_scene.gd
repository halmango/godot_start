extends Node2D

@onready var traffic_lights_1: Node2D = $TrafficLights
@onready var traffic_lights_2: Node2D = $TrafficLights2
@onready var traffic_lights_3: Node2D = $TrafficLights3


func _ready() -> void:
	traffic_lights_1.LightsLog.connect(log_print.bind(traffic_lights_1))
	traffic_lights_2.LightsLog.connect(log_print.bind(traffic_lights_2))
	traffic_lights_3.LightsLog.connect(log_print.bind(traffic_lights_3))


func log_print(prev: int, curr: int, node: Node2D):
	var p: String
	var c: String
	match prev:
		0:
			p = "Red"
		1:
			p = "Yellow"
		2:
			p = "Green"
	match curr:
		0:
			c = "Red"
		1:
			c = "Yellow"
		2:
			c = "Green"
	print("node: ", node, " prev: ", p, " curr: ", c)
