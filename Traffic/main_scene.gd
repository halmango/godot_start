extends Node2D

@onready var traffic_lights_1: Node2D = $TrafficLights
@onready var traffic_lights_2: Node2D = $TrafficLights2
@onready var traffic_lights_3: Node2D = $TrafficLights3


func _ready() -> void:
	traffic_lights_1.LightsLog.connect(log_print.bind(traffic_lights_1))
	traffic_lights_2.LightsLog.connect(log_print.bind(traffic_lights_2))
	traffic_lights_3.LightsLog.connect(log_print.bind(traffic_lights_3))


func log_print(prev: int, curr: int, node: Node2D):
	var p: String = TrafficLight.Lights.keys()[prev]
	var c: String = TrafficLight.Lights.keys()[curr]

	print("node: ", node, " prev: ", p, " curr: ", c)
