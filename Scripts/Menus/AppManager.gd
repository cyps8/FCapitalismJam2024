extends Node

class_name AppManager
static var ins: AppManager

@export var gameScene: PackedScene
@export var menuScene: PackedScene

enum Scene{
	MAINMENU,
	GAME
}

var optionsRef: OptionsMenu
var optionsOpen: bool = false

var loadingScreenRef: CanvasLayer

var currentSceneNode: Node = null
var currentPackedScene: PackedScene
var currentScene: Scene = Scene.GAME

var loading = false

func _init():
	ins = self

func _ready():
	optionsRef = $OptionsMenu
	optionsRef.visible = true
	remove_child(optionsRef)

	loadingScreenRef = $LoadingScreen
	loadingScreenRef.visible = true
	remove_child(loadingScreenRef)

	ChangeScene(Scene.MAINMENU)

func ChangeScene(newScene: Scene):
	if currentSceneNode != null:
		currentSceneNode.queue_free()

	if newScene == Scene.MAINMENU:
		currentPackedScene = menuScene
	elif newScene == Scene.GAME:
		currentPackedScene = gameScene

	add_child(loadingScreenRef)
		
	ResourceLoader.load_threaded_request(currentPackedScene.resource_path)
	loading = true

	currentScene = newScene

func OpenOptionsMenu():
	add_child(optionsRef)
	optionsOpen = true

func CloseOptionsMenu():
	remove_child(optionsRef)
	optionsOpen = false

func _physics_process(_delta):
	if !loading:
		return
	if ResourceLoader.load_threaded_get_status(currentPackedScene.resource_path) == ResourceLoader.THREAD_LOAD_LOADED:
		loading = false
		currentSceneNode = currentPackedScene.instantiate()
		add_child(currentSceneNode)
		HideLoadingScreen()

func HideLoadingScreen():
	remove_child(loadingScreenRef)
