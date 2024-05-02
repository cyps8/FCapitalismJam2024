extends Node

class_name GameScene
static var ins: GameScene

var pauseMenu: Pause

var pauseOpen: bool = false

func _init():
    ins = self

func _ready():
    pauseMenu = $Pause
    pauseMenu.visible = true
    remove_child(pauseMenu)

func SetPause(value: bool):
    if pauseOpen != value:
        TogglePause()

func TogglePause():
    pauseOpen = !pauseOpen
    if pauseOpen:
        add_child(pauseMenu)
        get_tree().paused = true
    else:
        remove_child(pauseMenu)
        get_tree().paused = false

func _process(_dt):
    if Input.is_action_just_pressed("Pause"):
        SetPause(true)