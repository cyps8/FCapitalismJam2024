extends CanvasLayer

class_name OptionsMenu

func _process(_dt):
	if Input.is_action_just_pressed("ui_cancel"):
		ReturnButton()

func ReturnButton():
	AppManager.ins.CloseOptionsMenu()