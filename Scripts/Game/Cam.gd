extends Camera3D

class_name Cam
static var ins: Cam

func _init():
	ins = self

func _process(dt):
	if Input.is_action_just_released("ZoomIn"):
		size *= 0.9
		size = clamp(size, 3.0, 15.0)
	elif Input.is_action_just_released("ZoomOut"):
		size *= 1.1
		size = clamp(size, 3.0, 15.0)

	if Input.is_action_pressed("MoveLeft"):
		if !Input.is_action_pressed("MoveRight"):
			Pan(Vector2(-1, 1), dt)
	elif Input.is_action_pressed("MoveRight"):
		Pan(Vector2(1, -1), dt)
	if Input.is_action_pressed("MoveUp"):
		if !Input.is_action_pressed("MoveDown"):
			Pan(-Vector2.ONE, dt)
	elif Input.is_action_pressed("MoveDown"):
		Pan(Vector2.ONE, dt)

func Pan(dir: Vector2, dt: float):
	position += Vector3(dir.x, 0, dir.y) * dt * size

var focusTween: Tween

func Focus(pos: Vector3, smooth: bool = true):
	if smooth:
		if focusTween != null:
			focusTween.kill()
		focusTween = create_tween()
		focusTween.tween_property(self, "position", pos + Vector3(10, 15, 10), 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	else:
		position = pos + Vector3(10, 15, 10)