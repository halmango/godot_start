extends ParallaxBackground

@onready var parallax_layer:   ParallaxLayer = $ParallaxLayer
@onready var parallax_layer_2: ParallaxLayer = $ParallaxLayer2
@onready var parallax_layer_3: ParallaxLayer = $ParallaxLayer3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parallax_layer.motion_offset.x -= 200 * delta
	parallax_layer_2.motion_offset.x -= 10 * delta
	parallax_layer_3.motion_offset.x -= 40 * delta
