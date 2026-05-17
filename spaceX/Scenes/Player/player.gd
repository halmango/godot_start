extends Area2D

const BOOST_SPEED : float = 150.0
const NORMAL_SPEED : float = 50.0

var velocity = Vector2.ZERO

var speed : float = NORMAL_SPEED

const MARGIN : float = 10.0
var _upper_left
var _lower_right

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_player_boundary()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_just_pressed("Boost"):
		speed = BOOST_SPEED
		$AnimatedEngineSprite.play("Boost")
		$Timer.start()
	
	velocity = direction * speed
	position += velocity * delta
	
	position = position.clamp(_upper_left, _lower_right) # 화면 밖으로 안나가게 포지션 셋팅
	
	if velocity.length() > 0:
		rotation = lerp_angle(rotation, velocity.angle(), 5 * delta)


func set_player_boundary() -> void:
	var vp_rect2 : Rect2 = get_viewport_rect() # 화면의 왼쪽 상단 좌표와 오른쪽 하단 좌표를 리턴함
	
	_upper_left = Vector2(MARGIN, MARGIN)
	_lower_right = Vector2(vp_rect2.size.x - MARGIN, vp_rect2.size.y - MARGIN)


func _on_timer_timeout() -> void:
	speed = NORMAL_SPEED
	$AnimatedEngineSprite.play("Idle")
