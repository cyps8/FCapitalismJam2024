extends CanvasLayer

class_name Pause

func _process(_dt):
	if Input.is_action_just_pressed("ui_cancel") && !AppManager.ins.optionsOpen:
		ResumeButton()

func ResumeButton():
	GameScene.ins.SetPause(false)

func OptionsButton():
	AppManager.ins.OpenOptionsMenu()

func MenuButton():
	AppManager.ins.ChangeScene(AppManager.Scene.MAINMENU)