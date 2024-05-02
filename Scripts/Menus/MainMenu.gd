extends CanvasLayer

class_name MainMenu

func StartButton():
	AppManager.ins.ChangeScene(AppManager.Scene.GAME)

func OptionsButton():
	AppManager.ins.OpenOptionsMenu()

func QuitButton():
	get_tree().quit()