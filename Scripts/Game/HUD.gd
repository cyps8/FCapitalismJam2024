extends CanvasLayer

func _process(dt):
	var camInputs: Vector2 = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	if camInputs == Vector2.ZERO:
		var mousePos: Vector2 = get_viewport().get_mouse_position()
		var viewportSize: Vector2 = get_viewport().size
		if mousePos.x <= 0:
			Cam.ins.Pan(Vector2(-1, 1), dt)
		elif mousePos.x >= viewportSize.x:
			Cam.ins.Pan(Vector2(1, -1), dt)
		if mousePos.y <= 0:
			Cam.ins.Pan(-Vector2.ONE, dt)
		elif mousePos.y >= viewportSize.y:
			Cam.ins.Pan(Vector2.ONE, dt)